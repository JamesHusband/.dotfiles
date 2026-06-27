import {Command} from '@oclif/core'

import {listPackages, packageRoots} from '../../lib/dotfiles.js'

export default class DotfilesList extends Command {
  static override description = 'List available dotfile packages'

  static override summary = 'List dotfile packages'

  async run(): Promise<void> {
    const roots = packageRoots()

    this.log('common:')
    for (const pkg of listPackages(roots.common)) this.log(`  ${pkg}`)

    this.log(`${roots.osName}:`)
    for (const pkg of listPackages(roots.osSpecific)) this.log(`  ${pkg}`)
  }
}
