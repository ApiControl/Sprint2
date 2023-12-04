var express = require("express");
var router = express.Router();

var colmeiasController = require("../controllers/colmeiasController");

router.get("/buscar/:fkEmpresa", function (req, res) {
  colmeiasController.buscarColmeiasPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  colmeiasController.cadastrar(req, res);
})

module.exports = router;