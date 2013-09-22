<?php
/**
*@package pXP
*@file gen-TipoEquipoCol.php
*@author  (admin)
*@date 19-03-2013 11:20:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoEquipoCol=Ext.extend(Phx.gridInterfaz,{

	constructor: function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoEquipoCol.superclass.constructor.call(this,config);
		this.init();
		
		//deshabilita botones
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		
		
		if(Phx.CP.getPagina(this.idContenedorPadre)){
			var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
		 	if(dataMaestro){
		 		this.onEnablePanel(this,dataMaestro)
		 	}
		}
		
		this.definicionEventos();

	},
	tam_pag:50,
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_equipo_col'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_tipo_equipo',
				labelSeparator: '',
				inputType: 'hidden'
			},
			type:'Field',
			form:true
		},
		{
			config: {
				name: 'tipo_col',
				fieldLabel: 'Tipo',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttipo_equipo_col__tipo_col'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['tipo_col']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters: {pfiltro:'teqcol.tipo_col',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'id',
				fieldLabel: 'Variables',
				allowBlank: false,
				emptyText:'Elija una columna...',
				valueField: 'id',
				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/TipoVariable/listarVariablesEquipo',
					id: 'id',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				displayField: 'nombre',
				gdisplayField:'desc_nombre',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_id']);},
				disabled:true
			},
			type:'ComboBox',
			filters:{pfiltro:'tvar.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_ficha',
				fieldLabel: 'Ficha Técnica',
				allowBlank: false,
				emptyText:'Elija una columna...',
				valueField: 'id_ficha',
				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/UniConsDet/listarColumnasFichaTec',
					id: 'id',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'udet.nombre'}
				}),
				displayField: 'nombre',
				gdisplayField:'desc_nombre',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_id']);},
				disabled:true
			},
			type:'ComboBox',
			id_grupo:0,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'orden',
				fieldLabel: 'Orden',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'NumberField',
			filters:{pfiltro:'teqcol.orden',type:'numeric'},
			id_grupo:1,
			grid:true,
			egrid:true,
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
			filters:{pfiltro:'teqcol.estado_reg',type:'string'},
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
				maxLength:4,
				hidden:true
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'teqcol.fecha_reg',type:'date'},
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
				maxLength:4,
				hidden:true
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'teqcol.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Tipo Equipo - Columnas',
	ActSave:'../../sis_mantenimiento/control/TipoEquipoCol/insertarTipoEquipoCol',
	ActDel:'../../sis_mantenimiento/control/TipoEquipoCol/eliminarTipoEquipoCol',
	ActList:'../../sis_mantenimiento/control/TipoEquipoCol/listarTipoEquipoCol',
	id_store:'id_tipo_equipo_col',
	fields: [
		{name:'id_tipo_equipo_col', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id', type: 'string'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'tipo_col', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'orden',
		'desc_id'
		
	],
	sortInfo:{
		field: 'id_tipo_equipo_col',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.TipoEquipoCol.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_tipo_equipo').setValue(this.maestro.id_tipo_equipo);
		this.getComponente('id').store.baseParams={id_tipo_equipo: this.maestro.id_tipo_equipo};		
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_tipo_equipo;
        if(m.id != 'id'){
	    	this.store.baseParams={id_tipo_equipo:this.maestro.id_tipo_equipo};
			this.load({params:{start:0, limit:50}});
			this.getComponente('id').store.baseParams={id_tipo_equipo: this.maestro.id_tipo_equipo};
       	}
		else{
			this.grid.getTopToolbar().disable();
   		 	this.grid.getBottomToolbar().disable(); 
   		 	this.store.removeAll(); 
       	}
	},

	definicionEventos: function(){
		//Definición de eventos
		this.getComponente('catalogo').on('select', function(e, data, index) {
			var cmbTipCol=this.getComponente('catalogo');
			var cmbId=this.getComponente('id');
			var cmbIdFicha=this.getComponente('id_ficha');
			
			if(cmbTipCol.getValue()=='Ficha Tecnica'){
				cmbId.disable();
				cmbIdFicha.enable();
				cmbId.allowBlank=true;
				cmbIdFicha.allowBlank=false;
			} else if(cmbTipCol.getValue()=='Variables'){
				cmbId.enable();
				cmbIdFicha.disable();
				cmbId.allowBlank=false;
				cmbIdFicha.allowBlank=true;
			}
			
			cmbId.setValue('');
			cmbId.modificado=true;			
			cmbId.store.setBaseParam('id_tipo_equipo',this.maestro.id_tipo_equipo)
			//cmbId.store.load({params:{start:0,limit:50,id_tipo_equipo:this.maestro.id_tipo_equipo}});

        },this);

	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	bedit:false
})
</script>
		
		