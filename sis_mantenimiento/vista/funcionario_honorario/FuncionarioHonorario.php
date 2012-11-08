<?php
/**
*@package pXP
*@file gen-FuncionarioHonorario.php
*@author  (admin)
*@date 22-09-2012 01:44:56
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioHonorario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FuncionarioHonorario.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario_honorario'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_tipo_horario',
				fieldLabel: 'Horario',
				allowBlank: false,
				emptyText:'Elija una horario...',
				store:new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/TipoHorario/listarTipoHorario',
					id: 'id_tipo_horario',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_tipo_horario','nombre','codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_horario',
				displayField: 'nombre',
				gdisplayField:'desc_tipo_horario',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_tipo_horario']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'gefuho.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcionario'
			},
			type:'Field',
			form:true 
		},
		{
	   		config:{
	       		    name:'id_moneda',
	   				origen:'MONEDA',
	   				tinit:true,
	   				fieldLabel:'Moneda',
	   				gdisplayField:'desc_moneda',//mapea al store del grid
	   			    gwidth:200,
	   			    witdth:'100%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_moneda']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'MONEDA.nombre',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
		{
			config:{
				name: 'costo_hora',
				fieldLabel: 'Costo/Hora',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'gefuho.costo_hora',type:'numeric'},
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
			filters:{pfiltro:'gefuho.estado_reg',type:'string'},
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
			filters:{pfiltro:'gefuho.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gefuho.fecha_mod',type:'date'},
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
	title:'Honorarios',
	ActSave:'../../sis_mantenimiento/control/FuncionarioHonorario/insertarFuncionarioHonorario',
	ActDel:'../../sis_mantenimiento/control/FuncionarioHonorario/eliminarFuncionarioHonorario',
	ActList:'../../sis_mantenimiento/control/FuncionarioHonorario/listarFuncionarioHonorario',
	id_store:'id_funcionario_honorario',
	loadValoresIniciales:function(){
		Phx.vista.FuncionarioHonorario.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_funcionario').setValue(this.maestro.id_funcionario);		
	},	
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_funcionario:this.maestro.id_funcionario};
		this.load({params:{start:0, limit:50}});			
	},
	fields: [
		{name:'id_funcionario_honorario', type: 'numeric'},
		{name:'id_tipo_horario', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_moneda', type: 'numeric'},
		{name:'costo_hora', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_horario', type: 'string'},
		{name:'desc_moneda', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_funcionario_honorario',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.FuncionarioHonorario.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_funcionario').setValue(this.maestro.id_funcionario);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_funcionario:this.maestro.id_funcionario};
		this.load({params:{start:0, limit:50}});			
	}
})
</script>
		
		