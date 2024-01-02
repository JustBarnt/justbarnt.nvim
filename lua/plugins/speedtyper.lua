return {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    opts = {
        window = {
            height = 5,
            width = 0.55,
            border = "single",
        },
        game_modes = {
            countdown = {
                time = 60,
            },
            stopwatch = {
                hide_time = true,
            },
            rain = {
                initial_speed = 1.5,
                throttle = 7,
                lives = 3,
            },
        },
        highlights = {
            untyped_text = "Comment",
            typo = "ErrorMsg",
            clock = "ErrorMsg",
            falling_word_typed = "DiagnosticOk",
            falling_word = "Normal",
            falling_word_warning1 = "WarningMsg",
            falling_word_warning2 = "ErrorMsg",
        },
    },
}
