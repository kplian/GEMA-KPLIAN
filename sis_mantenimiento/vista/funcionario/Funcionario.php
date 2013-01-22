<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  rcm
*@date 13/01/2012
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioGem = {
	require:'../../../sis_organigrama/vista/funcionario/Funcionario.php',
	requireclase:'Phx.vista.funcionario',
	title:'Funcionarios',
	bdel: true,
	bedit: true,
	bnew: true,
	constructor: function(config) {
		Phx.vista.FuncionarioGem.superclass.constructor.call(this,config);
		this.Atributos.push({
       			config:{
       				name:'id_especialidades',
       				fieldLabel:'Especialidades Técnicas',
       				allowBlank:true,
       				emptyText:'Especialidades...',
       				store: new Ext.data.JsonStore({
              			url: '../../sis_organigrama/control/Especialidad/listarEspecialidad',
       					id: 'id_especialidad',
       					root: 'datos',
       					sortInfo:{
       						field: 'nombre',
       						direction: 'ASC'
       					},
       					totalProperty: 'total',
       					fields: ['id_especialidad','codigo','nombre','desc_especialidad_nivel'],
       					// turn on remote sorting
       					remoteSort: true,
       					baseParams:{par_filtro:'espcia.nombre#espcia.codigo#espniv.nombre'}
       					
       				}),
       				valueField: 'id_especialidad',
       				displayField: 'nombre',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				anchor: '100%',
       				minChars:2,
	       			enableMultiSelect:true,
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}
       			},
       			type:'AwesomeCombo',
       			id_grupo:0,
       			grid:false,
       			form:true
       	},
       	{
       			config:{
       				name:'id_horarios',
       				fieldLabel:'Horarios',
       				allowBlank:true,
       				emptyText:'Horarios...',
       				store: new Ext.data.JsonStore({
              			url: '../../sis_organigrama/control/TipoHorario/listarTipoHorario',
       					id: 'id_tipo_horario',
       					root: 'datos',
       					sortInfo:{
       						field: 'nombre',
       						direction: 'ASC'
       					},
       					totalProperty: 'total',
       					fields: ['id_tipo_horario','codigo','nombre'],
       					// turn on remote sorting
       					remoteSort: true,
       					baseParams:{par_filtro:'nombre#codigo'}
       					
       				}),
       				valueField: 'id_tipo_horario',
       				displayField: 'nombre',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				anchor: '100%',
       				minChars:2,
	       			enableMultiSelect:true,
       				//renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}
       			},
       			type:'AwesomeCombo',
       			id_grupo:0,
       			grid:false,
       			form:true
       	});
		this.init();
		this.load({params:{start:0, limit:50}});
		console.log(this.Atributos);
		
	},
	tabsouth:[{
		  url:'../../../sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php',
		  title:'Especialidades Funcionarios', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'FuncionarioEspecialidad'
		},
		{
		  url:'../../../sis_mantenimiento/vista/funcionario_honorario/FuncionarioHonorario.php',
		  title:'Honorarios', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'FuncionarioHonorario'
		}
	]

};
</script>
