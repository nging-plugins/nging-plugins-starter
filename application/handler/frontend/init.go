package frontend

import (
	"github.com/coscms/webcore/library/module"
	"github.com/webx-top/echo"
)

func RegisterRoute(r module.Router) {
	r.Frontend().RegisterToGroup(`/forum`, registerRoute)
}

func registerRoute(g echo.RouteRegister) {

}
