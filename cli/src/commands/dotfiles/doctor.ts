import {Command} from '@oclif/core'

import {doctor} from '../../lib/dotfiles.js'

export default class DotfilesDoctor extends Command {
  static override description = 'Check dependencies and stowed symlink health'

  static override summary = 'Check dotfile projection health'

  async run(): Promise<void> {
    const result = doctor()
    for (const issue of result.issues) this.log(issue)

    if (result.issues.length > 0) {
      this.error(`${result.issues.length} issue(s) found`, {exit: 1})
    }

    this.log('dotfiles doctor passed')
  }
}
