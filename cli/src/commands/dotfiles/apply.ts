import {Command} from '@oclif/core'

import {applyDotfiles} from '../../lib/dotfiles.js'

export default class DotfilesApply extends Command {
  static override description = 'Stow common and OS-specific dotfiles into $HOME'

  static override summary = 'Apply dotfile projections'

  async run(): Promise<void> {
    const osName = applyDotfiles()
    this.log(`dotfiles applied for ${osName}`)
  }
}
