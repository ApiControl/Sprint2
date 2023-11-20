var express = require("express");
var router = express.Router();

var colmeiasController = require("../controllers/usuarioController");

router.get("/empresa/:idEmpresa", function (req, res) {
    colmeiasController.resgatarColmeiasPorEmpresa(req, res);
})

router.get("/colmeia/:idColmeia", function (req, res) {
    colmeiasController.resgatarColmeiaPorId(req, res);
})

module.exports = router;