<?php
/**
*@package pXP
*@file gen-Metodologia.php
*@author  (admin)
*@date 17-08-2012 15:52:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Indicadores=Ext.extend(Phx.grafInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Indicadores.superclass.constructor.call(this,config);
		
		this.fini= new Ext.form.DateField({
			name: 'fini',
			label: 'Fecha Inicio',
			emptyText:'Fecha Inicio'
    	});
    	this.ffin= new Ext.form.DateField({
			name: 'ffin',
			label: 'Fecha Final',
			emptyText:'Fecha Final'
    	});
    	this.cmbVar= new Ext.form.ComboBox({
			name: 'variable',
			label: 'Variable',
			emptyText:'Escoja una variable...',
			allowBlank: false,
			store:new Ext.data.JsonStore({
				url: '../../sis_mantenimiento/control/EquipoVariable/listarVariables',
				id: 'id_equipo_variable',
				root:'datos',
				sortInfo:{
					field:'nombre',
					direction:'ASC'
				},
				totalProperty:'total',
				fields: ['id_equipo_variable','id_tipo_variable','valor_max','valor_min','codigo','descripcion','id_unidad_medida','desc_un_med'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'nombre'}
			}),
			valueField: 'id_equipo_variable',
			displayField: 'descripcion',
			triggerAction: 'all',
			lazyRender:true,
			mode:'remote',
			pageSize:20,
			queryDelay:500
    	});
    	
    	this.tbar.add(this.fini);
    	this.tbar.add(this.ffin);
    	this.tbar.add(this.cmbVar);
		
		
		this.init();
	},
			
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons'
			},
			type:'Field',
			form:true 
		}
	],
	title:'Indicadores',
	ActSave:'../../sis_mantenimiento/control/Metodologia/insertarMetodologia',
	ActDel:'../../sis_mantenimiento/control/Metodologia/eliminarMetodologia',
	ActList:'../../sis_mantenimiento/control/Metodologia/listarMetodologia',
	id_store:'id_metodologia',
	loadValoresIniciales:function(){
		Phx.vista.Indicadores.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_uni_cons').setValue(this.maestro.id_uni_cons);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		//this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		//this.load({params:{start:0, limit:50}});			
	},
	fields: [
		{name:'id_metodologia', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_metodologia',
		direction: 'ASC'
	},
	bsave: false,
    bnew: false,
    bedit: false,
    bdel: false,
    ActList:'../../sis_mantenimiento/control/EquipoMedicion/listarMedicionGraf',
    id_store: 'id_equipo_medicion',
    sortInfo: 'fecha_medicion',
    fields: [
    'id_equipo_medicion','id_uni_cons','codigo','nombre','var_nombre','var_desc','cod_unimed','unimed_desc','fecha_medicion','medicion'
    ]
	}
)
</script>
		
		