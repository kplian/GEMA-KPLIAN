<?php
/**
*@package pXP
*@file gen-UniConsMantPredef.php
*@author  (admin)
*@date 12-10-2012 23:35:54
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniConsMantPredef=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.UniConsMantPredef.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, id_uni_cons:this.maestro.id_uni_cons}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons_mant_predef'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_mant_predef',
				fieldLabel: 'Mantenimiento',
				allowBlank: false,
				emptyText:'Elija un mantenimiento...',
				store:new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/MantPredef/listarMantPredefUC',
					id: 'id_mant_predef',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_mant_predef','nombre','codigo','descripcion','desc_tipo_equipo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_mant_predef',
				displayField: 'nombre',
				gdisplayField:'desc_mant_predef',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				width:300,
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_mant_predef']);}, 
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Código: <span style="color:#1406DD">{codigo}</span></p><p>Mantenimiento: <span style="color:#1406DD">{nombre}</span></p><p>Tipo Equipo: <span style="color:#1406DD">{desc_tipo_equipo}</span></p></div></tpl>',
			},
			type:'ComboBox',
			filters:{pfiltro:'gemapr.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_unidad_medida',
				fieldLabel: 'Unidad de Medida',
				allowBlank: false,
				origen: 'UNIDADMEDIDA',
				gdisplayField: 'desc_unidad_medida_estimado',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_unidad_medida']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'um.codigo',type:'string'},
			grid: true,
			form: true
		},
		/*{
       			config:{
       				name:'id_unidad_medida',
       				fieldLabel:'Unidad de Medida',
       				allowBlank:false,
       				emptyText:'Unidades...',
       				store: new Ext.data.JsonStore({
    					url: '../../sis_parametros/control/UnidadMedida/listarUnidadMedida',
    					id: 'id_unidad_medida',
    					root: 'datos',
    					sortInfo:{
    						field: 'codigo',
    						direction: 'ASC'
    					},
    					totalProperty: 'total',
    					fields: ['id_unidad_medida','codigo','descripcion'],
      					// turn on remote sorting
    					remoteSort: true,
    					baseParams:{par_filtro:'codigo#descripcion'}
    				}),
    				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo} - {descripcion} </p></div></tpl>',
	       			
       				valueField: 'id_unidad_medida',
       				displayField: 'codigo',
       				gdisplayField: 'desc_unidad_medida',
       				hiddenName: 'id_unidad_medida',
       				//forceSelection:false,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:150,
       				minChars:2,
       				minListWidth:300,
       				renderer:function(value, p, record){return String.format('{0}', record.data['desc_unidad_medida']);}

       			},
       			type:'ComboBox',
       			id_grupo:0,
       			filters:{   pfiltro:'um.codigo',
       						type:'string'
       					},
       			grid:true,
       			form:true
       	},*/
		{
			config:{
				name: 'frecuencia',
				fieldLabel: 'Frecuencia',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geeqma.frecuencia',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'ult_fecha_mant',
				fieldLabel: 'Últ. Fecha Mant.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geeqma.ult_fecha_mant',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Desde',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				format:'m/d/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geeqma.fecha_ini',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_unidad_medida_estimado',
				fieldLabel: 'Unidad Medida',
				allowBlank: false,
				origen: 'UNIDADMEDIDA',
				gdisplayField: 'desc_unidad_medida_estimado',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_unidad_medida_estimado']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'geeqma.tipo',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'tiempo_estimado',
				fieldLabel: 'Tiempo estimado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geeqma.tiempo_estimado',type:'numeric'},
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
			filters:{pfiltro:'geeqma.estado_reg',type:'string'},
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
			filters:{pfiltro:'geeqma.fecha_reg',type:'date'},
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
			filters:{pfiltro:'geeqma.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Equipo - Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/UniConsMantPredef/insertarUniConsMantPredef',
	ActDel:'../../sis_mantenimiento/control/UniConsMantPredef/eliminarUniConsMantPredef',
	ActList:'../../sis_mantenimiento/control/UniConsMantPredef/listarUniConsMantPredef',
	id_store:'id_uni_cons_mant_predef',
	fields: [
		{name:'id_uni_cons_mant_predef', type: 'numeric'},
		{name:'id_mant_predef', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_unidad_medida', type: 'numeric'},
		{name:'frecuencia', type: 'numeric'},
		{name:'ult_fecha_mant', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_ini', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_mant_predef', type: 'string'},
		{name:'desc_unidad_medida', type: 'string'},
		{name:'id_unidad_medida_estimado', type: 'numeric'},
		{name:'tiempo_estimado', type: 'numeric'},
		{name:'desc_unidad_medida_estimado', type: 'string'}
	],
	sortInfo:{
		field: 'id_uni_cons_mant_predef',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.UniConsMantPredef.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_uni_cons').setValue(this.maestro.id_uni_cons);
		this.getComponente('id_mant_predef').store.baseParams={par_filtro:'nombre',id_uni_cons:this.maestro.id_uni_cons};
	},	
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:50}});			
	}
}
)
</script>
		
		