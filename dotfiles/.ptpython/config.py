__all__ = ('configure',)


def configure(repl):
    # Disable autocompletion while typing
    repl.complete_while_typing = False

    # Don't ask for confirmation on exit
    repl.confirm_exit = False

    # Show autosuggestions
    repl.enable_auto_suggest = True

    # Use current input when scrolling through history
    repl.enable_history_search = True

    # Highlight matching parenthesis
    repl.highlight_matching_parenthesis = True

    # Use classic prompt
    repl.prompt_style = 'classic'

    # Show line numbers for multiline input
    repl.show_line_numbers = True

    # Enable vi mode
    repl.vi_mode = True

    # Colorscheme
    repl.use_code_colorscheme('monokai')
