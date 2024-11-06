package forum

import (
	"github.com/coscms/webcore/library/module"

	"github.com/nging-plugins/forum/application/handler"
	"github.com/nging-plugins/forum/application/library/setup"
)

const ID = `forum`

var Module = module.Module{
	Startup: ID,
	TemplatePath: map[string]string{
		ID: `forum/template/backend`,
	},
	AssetsPath: []string{
		`forum/public/assets`,
	},
	SQLCollection: setup.RegisterSQL,
	//Dashboard:     RegisterDashboard,
	Navigate:    handler.RegisterNavigate,
	Route:       handler.RegisterRoute,
	DBSchemaVer: 0.1,
}
