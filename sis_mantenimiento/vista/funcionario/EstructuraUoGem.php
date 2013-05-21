<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  rcm
*@date 19/05/2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EstructuraUoGem = {
	require:'../../../sis_organigrama/vista/estructura_uo/EstructuraUo.php',
	requireclase:'Phx.vista.EstructuraUo',
	title:'Funcionarios x Unidad',
	bdel: true,
	bedit: true,
	bnew: true,
	constructor: function(config) {
       	Phx.vista.EstructuraUo.superclass.constructor.call(this,config);
		this.init();
		//Creación de menú contextual
		this.crearCtxMenu();
		//Adiciona los botones
		this.addBotones();
		
		//coloca elementos en la barra de herramientas
		this.tbar.add('->');
   		this.tbar.add(' Filtrar:');
   		this.tbar.add(this.datoFiltro);
   		
   		this.loaderTree.baseParams={id_subsistema:this.id_subsistema};
		this.rootVisible=false;
   		
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	dirReporte: '../../../sis_mantenimiento/vista/funcionario/RepFuncionarioUoGem.php',
	clsReporte: 'RepFuncionarioUoGem'
};
</script>
