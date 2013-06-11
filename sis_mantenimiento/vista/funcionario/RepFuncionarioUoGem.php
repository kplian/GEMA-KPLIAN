<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  rcm
*@date 18/05/2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.RepFuncionarioUoGem = {
	require:'../../../sis_organigrama/vista/estructura_uo/RepFuncionarioUo.php',
	requireclase:'Phx.vista.RepFuncionarioUo',
	title:'Funcionarios x Unidad',
	AtributosExtra:[{
	       	config:{
	       			name: 'horario1',
	       			fieldLabel: "HH Normal (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:false,	
	       			anchor:'50%',
	       			hiddenName:'horario1'
	       			
	       		},
	       		type:'NumberField',
	       		filters:{type:'numeric'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
       	{
	       	config:{
	       			name: 'horario2',
	       			fieldLabel: "HH Extra (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			anchor:'50%',
	       			hiddenName:'horario2'
	       		},
	       		type:'NumberField',
	       		filters:{type:'numeric'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
       	{
	       	config:{
	       			name: 'horario3',
	       			fieldLabel: "HH Nocturno (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			anchor:'50%',
	       			hiddenName:'horario3'
	       		},
	       		type:'NumberField',
	       		filters:{type:'numeric'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
	     {
	       	config:{
	       			name: 'horario4',
	       			fieldLabel: "HH Fer. y Dom. (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			anchor:'50%',
	       			hiddenName:'horario4'
	       		},
	       		type:'NumberField',
	       		filters:{type:'numeric'},
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     }
	],

	constructor: function(config) {
       	Phx.vista.RepFuncionarioUoGem.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50,fecha:this.dteFecha.getValue(),id_uo:this.maestro.id_uo}})
	},
	ActList:'../../sis_mantenimiento/control/Funcionario/listarFuncionarioUo',
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'

};
</script>
