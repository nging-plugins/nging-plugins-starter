//go:build embedNgingPluginTemplate

package forum

import (
	"embed"
)

//go:embed template
var TemplateFS embed.FS

//go:embed public
var AssetsFS embed.FS
