package forum

import (
	"github.com/coscms/webcore/library/module"

	"github.com/nging-plugins/nging-plugins-starter/application/handler"
	"github.com/nging-plugins/nging-plugins-starter/application/library/setup"
)

const ID = `nging-plugins-starter`

var Module = module.Module{
	//Startup: ID,
	TemplatePath: map[string]string{
		ID: `nging-plugins-starter/template/backend`,
	},
	AssetsPath: []string{
		`nging-plugins-starter/public/assets`,
	},
	SQLCollection: setup.RegisterSQL,
	//Dashboard:     RegisterDashboard,
	Navigate:    handler.RegisterNavigate,
	Route:       handler.RegisterRoute,
	DBSchemaVer: 0.1,
}
