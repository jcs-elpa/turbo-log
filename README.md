<a href="https://github.com/jcs-elpa/turbo-log"><img align="right" src="./etc/logo.png" width="128" height="128"></a>

# turbo-log

[![Build Status](https://travis-ci.com/jcs-elpa/turbo-log.svg?branch=master)](https://travis-ci.com/jcs-elpa/turbo-log)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This extension make debugging much easier by automating the operation of
writing meaningful log message.

*P.S. Inspired by VSCode plugin, [Turbo Console Log](https://marketplace.visualstudio.com/items?itemName=ChakrounAnas.turbo-console-log).*

## How to use?

1. Region select a variable
2. `M-x turbo-log`

## Add your own language?

N/A

## Customization

This package only has one command `turbo-log`. I would recommend you
bind this command to a keymap.

```el
(define-key [your-mode-map] (kbd "[key]") #'turbo-log)
```

* `turbo-log-prefix` - default to `"╘[TL] "`
  - Prefix string inserted before variable name.

* `turbo-log-prefix-delimiter` - default to `: `
  - N/A

* `turbo-log-prefix-intial` - default to `t`
  - N/A

* `turbo-log-no-ask` - default to `nil`
  - N/A

## Contribution

If you would like to contribute to this project, you may either
clone and make pull requests to this repository. Or you can
clone the project and establish your own branch of this tool.
Any methods are welcome!
