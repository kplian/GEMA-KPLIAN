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
       	Phx.vista.EstructuraUoGem.superclass.constructor.call(this,config);
		this.init();
		//Creación de menú contextual
		//this.crearCtxMenu();
		//Adiciona los botones
		//this.addBotones();
		this.addButton('btnReporteFun',	{
				text: 'Funcionarios',
				//iconCls: 'bchecklist',
				disabled: false,
				handler: this.onBtnReporteFun,
				tooltip: '<b>Funcionarios</b><br/>Listado de funcionarios por unidad organizacional'
			}
		);	
		
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
	clsReporte: 'RepFuncionarioUoGem',
	onBtnReporteFun: function(){
		var node = this.sm.getSelectedNode();
			var data = node.attributes;
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/funcionario/RepFuncionarioUoGem.php',
					'Funcionarios',
					{
						width:1000,
						height:600
				    },
				    data,
				    this.idContenedor,
				    'RepFuncionarioUoGem'
			);
	}
};
</script>
