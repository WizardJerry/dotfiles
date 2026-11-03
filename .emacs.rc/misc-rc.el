;;; Miscellaneous Configuration

;; Startup
(setq inhibit-startup-screen t)

;; Interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)

;; Appearance
(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :family "Sarasa Mono SC Nerd Font"
                      :height 130
                      :background "#1D1F21"
                      :foreground "#D8DEE9"))

;; https://github.com/rexim/gruber-darker-theme
(setq-default cursor-type 'box)
(set-face-attribute 'cursor nil :background "#ffdd33")

(set-face-attribute 'region nil
                    :background "#484848"
                    :foreground 'unspecified)

(when (fboundp 'global-display-line-numbers-mode)
  (setq-default display-line-numbers-type 'relative
                display-line-numbers-current-absolute t)
  (global-display-line-numbers-mode 1)
  (set-face-attribute 'line-number nil
                      :inherit 'default
                      :foreground "#52494e"
                      :background 'unspecified)
  (set-face-attribute 'line-number-current-line nil
                      :inherit 'line-number
                      :foreground "#ffdd33"
                      :background 'unspecified))

(set-face-attribute 'fringe nil
                    :inherit 'default
                    :background 'unspecified)
