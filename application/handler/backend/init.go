package backend

import (
	"github.com/coscms/webcore/library/module"
	"github.com/webx-top/echo"
)

func RegisterNavigate(nc module.Navigate) {
	nc.Backend().Project(`webx`).AddLeftItems(-1, LeftNavigate)
}

func RegisterRoute(r module.Router) {
	r.Backend().RegisterToGroup(`/forum`, registerRoute)
}

func registerRoute(g echo.RouteRegister) {

}
