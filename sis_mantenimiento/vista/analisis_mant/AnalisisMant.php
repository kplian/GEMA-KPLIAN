<?php
/**
*@package pXP
*@file gen-AnalisisMant.php
*@author  (admin)
*@date 30-09-2012 21:44:06
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AnalisisMant=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AnalisisMant.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_analisis_mant'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_tipo_mant',
				fieldLabel: 'Tipo Mantenimiento',
				allowBlank: false,
				emptyText:'Elija un tipo de mantenimiento...',
				store:new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/TipoMant/listarTipoMant',
					id: 'id_tipo_mant',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_tipo_mant','nombre','codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_mant',
				displayField: 'nombre',
				gdisplayField:'desc_tipo_mant',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_tipo_mant']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'geanma.nombre',type:'string'},
			id_grupo:0,
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
			filters:{pfiltro:'geanma.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_emision',
				fieldLabel: 'Fecha de Emisión',
				allowBlank: true,
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				format:'m/d/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geanma.fecha_emision',type:'date'},
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
				maxLength:100
			},
			type:'TextArea',
			filters:{pfiltro:'geanma.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
	   		config:{
	       		    name:'id_funcionario_rev',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				fieldLabel:'Funcionario Rev.',
	   				gdisplayField:'desc_person',//mapea al store del grid
	   			    gwidth:200,
	   			    witdth:'100%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'PERSON.nombre_completo1',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
		
		{
			config:{
				name: 'fecha_rev',
				fieldLabel: 'Fecha Rev.',
				allowBlank: true,
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				format:'m/d/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geanma.fecha_rev',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'geanma.fecha_reg',type:'date'},
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
			filters:{pfiltro:'geanma.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Análisis de Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/AnalisisMant/insertarAnalisisMant',
	ActDel:'../../sis_mantenimiento/control/AnalisisMant/eliminarAnalisisMant',
	ActList:'../../sis_mantenimiento/control/AnalisisMant/listarAnalisisMant',
	id_store:'id_analisis_mant',
	fields: [
		{name:'id_analisis_mant', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'id_funcionario_rev', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_emision', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'descripcion', type: 'string'},
		{name:'fecha_rev', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_mant', type: 'string'},
		{name:'desc_person', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_analisis_mant',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function()
	{
		Phx.vista.AnalisisMant.superclass.loadValoresIniciales.call(this);
	//	this.getComponente('id_cobro').setValue(this.maestro.id_cobro);		
	},
				
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:50,}});			
	},
	south:{
		  url:'../../../sis_mantenimiento/vista/funcion/Funcion.php',
		  title:'Funciones', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'FFuncion'
	}
})
</script>
		
		