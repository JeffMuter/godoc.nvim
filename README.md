# godoc.nvim


This plugin allows use of the functionality of the CLI 'go doc', but within Neovim.

Any and all suggestions for improvements, or functionality that is cohesive to the intent of this project, I beg you let me know so I can implement this for you and all users to benefit from.

The intent is to give you neovim motions, and search functionality within a window in neovim, instead of doing so in a terminal

The functionality is exactly the same as 'go doc', all of it's CLI functionality.

The utility of this plugin is entirely dependent on one's use of the 'go doc' command. So I'll highlight what that cli does.

In summary, it shows the documentation for golang packages locally, through the cli and entirely text based, and remotely.

Often I found myself reading documentation via the web app. For fmt, I'd use this URL:

https://pkg.go.dev/fmt

However, 'godoc' allows us to see the same text, in more specific ways via a CLI.

One final time I'll highlight how this works, and why it's so fast, namely, all of it is locally installed already. For the standard library especially, those documents are stored on your local system.

If a package is installed via the go package manager on a specific repo, you have installed that package, and its subsequent documentation, and thus, in that repo, you can view that documentation yourself locally.

Some example commands would be:

// get docs on a standard lib package
"Godoc fmt"

// get docs on a package already installed, 
:Godoc bluenviron/gortsplib/v4

// get docs on a specific function from a package
:Godoc fmt.Println

// get docs on a type struct from a package, and all of its method declarations.
:Godoc http.Client

// get docs for a package type's specific method implementation.
:Godoc http.Client.Do

// you can also use different flags, for more specific docs. 
// '-all' gives more detailed documentation, methods, nested types.

// 'src' gives source code in its entirety

// flags can be combined like so, to see all documentation, and implementation details:
Godoc -src -all fmt.Println
