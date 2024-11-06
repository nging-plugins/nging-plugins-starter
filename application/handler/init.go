package handler

import (
	"github.com/coscms/webcore/library/module"
	"github.com/nging-plugins/forum/application/handler/backend"
	"github.com/nging-plugins/forum/application/handler/frontend"
)

func RegisterRoute(r module.Router) {
	backend.RegisterRoute(r)
	frontend.RegisterRoute(r)
}

func RegisterNavigate(nc module.Navigate) {
	backend.RegisterNavigate(nc)
}
