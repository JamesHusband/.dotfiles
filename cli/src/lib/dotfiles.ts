import {execFileSync} from 'node:child_process'
import fs from 'node:fs'
import os from 'node:os'
import path from 'node:path'
import {fileURLToPath} from 'node:url'

import type {DoctorResult, PackageRoots} from '../../types/index.js'

const sourceFile = fileURLToPath(import.meta.url)

function findDotfilesRoot(start: string): string {
  let current = start
  while (current !== path.dirname(current)) {
    if (fs.existsSync(path.join(current, 'common')) && fs.existsSync(path.join(current, 'os'))) return current
    current = path.dirname(current)
  }

  throw new Error('could not resolve dotfiles root')
}

export const dotfilesRoot = findDotfilesRoot(path.dirname(sourceFile))

export function commandExists(command: string): boolean {
  const pathValue = process.env.PATH ?? ''
  return pathValue
    .split(path.delimiter)
    .filter(Boolean)
    .some((dir) => fs.existsSync(path.join(dir, command)))
}

export function detectOs(): string {
  const platform = os.platform()
  if (platform === 'darwin') return 'macos'
  if (platform !== 'linux') throw new Error(`unsupported operating system: ${platform}`)

  if (fs.existsSync('/etc/debian_version')) return 'debian'
  if (fs.existsSync('/etc/arch-release')) return 'arch'
  throw new Error('unsupported Linux distribution')
}

export function listPackages(packageRoot: string): string[] {
  if (!fs.existsSync(packageRoot)) return []
  return fs
    .readdirSync(packageRoot, {withFileTypes: true})
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name)
    .sort()
}

export function packageRoots(osName = detectOs()): PackageRoots {
  return {
    common: path.join(dotfilesRoot, 'common'),
    osName,
    osSpecific: path.join(dotfilesRoot, 'os', osName),
  }
}

export function stowPackageSet(sourceDir: string, counterpartDir: string, home = os.homedir()): void {
  for (const pkg of listPackages(sourceDir)) {
    const args = [`--target=${home}`, `--dir=${sourceDir}`, '--ignore=.DS_Store']
    if (fs.existsSync(path.join(counterpartDir, pkg))) args.push('--no-folding')
    args.push(pkg)
    execFileSync('stow', args, {stdio: 'inherit'})
  }
}

export function applyDotfiles(home = os.homedir()): string {
  if (!commandExists('stow')) throw new Error('stow is required')
  const roots = packageRoots()
  stowPackageSet(roots.common, roots.osSpecific, home)
  stowPackageSet(roots.osSpecific, roots.common, home)
  return roots.osName
}

function walkFiles(dir: string): string[] {
  const results: string[] = []
  if (!fs.existsSync(dir)) return results

  for (const entry of fs.readdirSync(dir, {withFileTypes: true})) {
    if (entry.name === '.DS_Store' || entry.name === '.stow-local-ignore') continue
    const fullPath = path.join(dir, entry.name)
    if (entry.isDirectory()) {
      results.push(...walkFiles(fullPath))
    } else if (entry.isFile()) {
      results.push(fullPath)
    }
  }

  return results
}

function realLinkTarget(target: string): string {
  const link = fs.readlinkSync(target)
  const linkPath = path.isAbsolute(link) ? link : path.join(path.dirname(target), link)
  return fs.realpathSync(linkPath)
}

export function checkStowDir(packageRoot: string, home = os.homedir()): string[] {
  const issues: string[] = []
  if (!fs.existsSync(packageRoot)) return issues

  for (const pkg of listPackages(packageRoot)) {
    const pkgRoot = path.join(packageRoot, pkg)
    for (const file of walkFiles(pkgRoot)) {
      const rel = path.relative(pkgRoot, file)
      const target = path.join(home, rel)

      let stat: fs.Stats
      try {
        stat = fs.lstatSync(target)
      } catch {
        issues.push(`missing: ~/${rel} (${pkg})`)
        continue
      }

      if (stat.isSymbolicLink() && !fs.existsSync(target)) {
        issues.push(`broken: ~/${rel} -> ${fs.readlinkSync(target)}`)
        continue
      }

      const resolved = stat.isSymbolicLink() ? realLinkTarget(target) : fs.realpathSync(target)
      if (!resolved.startsWith(`${dotfilesRoot}${path.sep}`)) {
        issues.push(`foreign: ~/${rel} -> ${resolved}`)
      }
    }
  }

  return issues
}

export function doctor(home = os.homedir()): DoctorResult {
  const issues: string[] = []
  for (const command of ['git', 'stow', 'zsh']) {
    if (!commandExists(command)) issues.push(`missing dependency: ${command}`)
  }

  const roots = packageRoots()
  issues.push(...checkStowDir(roots.common, home))
  issues.push(...checkStowDir(roots.osSpecific, home))
  return {issues, osName: roots.osName}
}
