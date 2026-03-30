//go:build embedNgingPluginTemplate

package ngingpluginsstarter

import (
	"embed"
)

//go:embed template
var TemplateFS embed.FS

//go:embed public
var AssetsFS embed.FS
