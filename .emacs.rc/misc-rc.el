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