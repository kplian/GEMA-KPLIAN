<?php
/**
*@package pXP
*@file gen-Issue.php
*@author  (admin)
*@date 10-12-2012 19:16:36
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Issue=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Issue.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
		
		this.addButton('btnImport', {
				text : 'Importar',
				iconCls : 'block',
				handler : this.onBtnImport,
				tooltip : '<b>Importar Issues</b><br/>Importa y actualiza la información de los Issues'
			});
			
		this.getBoton('btnImport').enable();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_issue'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nro_issue',
				fieldLabel: 'Nro.Issue',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'issue.nro_issue',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'titulo',
				fieldLabel: 'Título Issue',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'issue.titulo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2000
			},
			type:'TextField',
			filters:{pfiltro:'issue.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_hrs',
				fieldLabel: 'Tiempo Hrs.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'issue.tiempo_hrs',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'semana',
				fieldLabel: 'Semana',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'issue.semana',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'prioridad',
				fieldLabel: 'Prioridad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'issue.prioridad',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'developer',
				fieldLabel: 'Dev',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'issue.developer',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'labels',
				fieldLabel: 'Labels',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'issue.labels',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'milestone',
				fieldLabel: 'Milestone',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'issue.milestone',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'issue.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'creador',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'issue.creador',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_cierre',
				fieldLabel: 'Cerrado en',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'issue.fecha_cierre',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'fecha_act',
				fieldLabel: 'Modificado en',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'issue.fecha_act',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'issue.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'issue.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'issue.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Issue',
	ActSave:'../../sis_kgestion/control/Issue/insertarIssue',
	ActDel:'../../sis_kgestion/control/Issue/eliminarIssue',
	ActList:'../../sis_kgestion/control/Issue/listarIssue',
	id_store:'id_issue',
	fields: [
		{name:'id_issue', type: 'numeric'},
		{name:'titulo', type: 'string'},
		{name:'creador', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'nro_issue', type: 'numeric'},
		{name:'milestone', type: 'string'},
		{name:'developer', type: 'string'},
		{name:'fecha_cierre', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'labels', type: 'string'},
		{name:'fecha_act', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'tiempo_hrs', type: 'numeric'},
		{name:'semana', type: 'string'},
		{name:'prioridad', type: 'numeric'}
	],
	sortInfo:{
		field: 'id_issue',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onBtnImport:function(){
		
		if(confirm('Al importar los datos se eliminarán todos los Issues actuales.\n ¿Está seguro de continuar?')){
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url:'../../sis_kgestion/control/Issue/updateIssues',
				params:{'issue':'kplian'},
				success: function(resp){
					Phx.CP.loadingHide();
					var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
					if(!reg.ROOT.error){
						this.reload();
						Ext.Msg.alert('Respuesta',reg.ROOT.detalle.mensaje);
						
					}else{
						Ext.Msg.alert('Alerta','Ha ocurrido un error durante el proceso')
					}
				},
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
	}
})
</script>
		
		