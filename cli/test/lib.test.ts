import {expect} from 'chai'
import {mkdirSync, rmSync, writeFileSync} from 'node:fs'
import {homedir} from 'node:os'
import {join} from 'node:path'
import {tmpdir} from 'node:os'

import {checkStowDir, commandExists, detectOs, listPackages, packageRoots} from '../src/lib/dotfiles.js'

function mkTmpDir(): string {
  const dir = join(tmpdir(), `dotfiles-test-${Date.now()}-${Math.random().toString(36).slice(2)}`)
  mkdirSync(dir, {recursive: true})
  return dir
}

function rmTmpDir(dir: string): void {
  rmSync(dir, {force: true, recursive: true})
}

describe('commandExists', () => {
  it('returns true for commands that are on PATH (sh)', () => {
    expect(commandExists('sh')).to.be.true
  })

  it('returns false for an unlikely fake command', () => {
    expect(commandExists('__no_such_command_bobos_test__')).to.be.false
  })
})

describe('detectOs', () => {
  it('returns "macos" on macOS', () => {
    const result = detectOs()
    expect(result).to.equal('macos')
  })
})

describe('listPackages', () => {
  let tmp: string

  beforeEach(() => { tmp = mkTmpDir() })
  afterEach(() => rmTmpDir(tmp))

  it('returns empty array for a missing directory', () => {
    expect(listPackages(join(tmp, 'nonexistent'))).to.deep.equal([])
  })

  it('returns only directory names, sorted', () => {
    mkdirSync(join(tmp, 'zsh'))
    mkdirSync(join(tmp, 'git'))
    writeFileSync(join(tmp, 'file.txt'), '')
    expect(listPackages(tmp)).to.deep.equal(['git', 'zsh'])
  })
})

describe('packageRoots', () => {
  it('returns common and osSpecific paths', () => {
    const roots = packageRoots('macos')
    expect(roots.common).to.be.a('string')
    expect(roots.osSpecific).to.be.a('string')
    expect(roots.osName).to.equal('macos')
  })
})

describe('checkStowDir', () => {
  let src: string
  let home: string

  beforeEach(() => {
    src = mkTmpDir()
    home = mkTmpDir()
  })

  afterEach(() => {
    rmTmpDir(src)
    rmTmpDir(home)
  })

  it('returns no issues for an empty package root', () => {
    expect(checkStowDir(src, home)).to.deep.equal([])
  })

  it('reports missing when a file is not projected', () => {
    mkdirSync(join(src, 'git'))
    writeFileSync(join(src, 'git', '.gitconfig'), '')
    const issues = checkStowDir(src, home)
    expect(issues.length).to.be.greaterThan(0)
    expect(issues[0]).to.include('missing')
  })
})
