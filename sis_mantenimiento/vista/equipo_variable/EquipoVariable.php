<?php
/**
*@package pXP
*@file gen-EquipoVariable.php
*@author  (rac)
*@date 15-08-2012 17:09:17
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EquipoVariable=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.EquipoVariable.superclass.constructor.call(this,config);
		this.init();
		//this.grid.getTopToolbar().disable();
		//this.grid.getBottomToolbar().disable();
		
		this.iniciarEventos();
		this.onReloadPage(this.maestro)
		
		
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_equipo_variable'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_uni_cons',
				fieldLabel: 'id_uni_cons',
				inputType:'hidden'
			},
			type:'Field',
			form:true
		},
		{
	       			config:{
	       				 typeAhead: false,
	       				  hideTrigger:true,
	       				  forceSelection:false,
	       				  name:'id_tipo_variable',
	       				  fieldLabel:'Nombre Atributo',
	       				  allowBlank:false,
	       				  emptyText:'Tipos...',
	       				  store: new Ext.data.JsonStore({

	    					url: '../../sis_mantenimiento/control/TipoVariable/listarTipoVariable',
	    					id: 'id_tipo_variable',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'nombre',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_tipo_variable','nombre','descripcion','codigo_unidad_medida','id_unidad_medida'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'tva.nombre#tva.descripcion'}
	    				}),
	    				rawValueField:'nombre_tipo_variable',//campo adicional utilizado para utilizar el combo como insercion
	    				hiddenName: 'id_tipo_variable',
	    			    valueField: 'id_tipo_variable',
	       				displayField: 'nombre',
	       				gdisplayField: 'nombre_tipo_variable',
	       				//typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:200,
	       				width:250,
	       				minChars:2,
	       				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_tipo_variable']);},
		       			tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre} ({codigo_unidad_medida})</p></div></tpl>'
		   			},
	       			type:'ComboBox',
	       			id_grupo:1,
	       			filters:{   pfiltro:'tva.descripcion#tva.nombre',
	       						type:'string'
	       					},
	       			grid:true,
	       			form:true
	       	},
	       	{
       			config:{
       				name:'id_unidad_medida',
       				fieldLabel:'Unidad de Medida',
       				allowBlank:true,
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
       				gdisplayField: 'codigo_unidad_medida',
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
       				renderer:function(value, p, record){return String.format('{0}', record.data['codigo_unidad_medida']);}

       			},
       			type:'ComboBox',
       			id_grupo:0,
       			filters:{   pfiltro:'um.codigo',
       						type:'string'
       					},
       			grid:true,
       			form:true
       	},
	       	{
	       		config:{
	       			name:'tipo',
	       			fieldLabel:'Tipo dato',
	       			allowBlank:false,
	       			emptyText:'Estilo...',
	       			
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    //readOnly:true,
	       		    valueField: 'tipo',
	       		   // displayField: 'descestilo',
	       		    store:['numeric','text']
	       		    
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['numeric','text'],	
	       		 	},
	       		grid:true,
	       		form:true
	       	},
		{
			config:{
				name: 'valor_min',
				fieldLabel: 'Minimo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'eqv.valor_min',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'valor_max',
				fieldLabel: 'Maximo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'eqv.valor_max',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'obs',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:255
			},
			type:'TextArea',
			filters:{pfiltro:'eqv.obs',type:'string'},
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
			filters:{pfiltro:'eqv.estado_reg',type:'string'},
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
			filters:{pfiltro:'eqv.fecha_reg',type:'date'},
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
			filters:{pfiltro:'eqv.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Variables del Equipo',
	ActSave:'../../sis_mantenimiento/control/EquipoVariable/insertarEquipoVariable',
	ActDel:'../../sis_mantenimiento/control/EquipoVariable/eliminarEquipoVariable',
	ActList:'../../sis_mantenimiento/control/EquipoVariable/listarEquipoVariable',
	id_store:'id_equipo_variable',
	
	onReloadPage:function(m){
        this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_uni_cons;
		
		var cmb = this.getComponente('id_tipo_variable');
		cmb.store.baseParams.id_tipo_equipo = this.maestro.id_tipo_equipo;
		
		
        cmb.modificado=true;
 
		// this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
    	//   this.grid.getTopToolbar().enable();
     	//	 this.grid.getBottomToolbar().enable();  

		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:50}})
       
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


	},
	fields: ['tipo','codigo_unidad_medida','id_unidad_medida','nombre_tipo_variable',
		{name:'id_equipo_variable', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'valor_max', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'obs', type: 'string'},
		{name:'valor_min', type: 'numeric'},
		{name:'id_tipo_variable', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
		iniciarEventos:function(){
			
			var cmbUM = this.getComponente('id_unidad_medida');
		
			this.getComponente('id_tipo_variable').on('beforeselect',function(combo,record,index){
				
				console.log(combo,record,index)
					cmbUM.setValue(record.data.id_unidad_medida);
					cmbUM.setRawValue(record.data.codigo_unidad_medida);
				    
				
			},this)
		
		
		
		
	},
	agregarArgsExtraSubmit: function(){
		//Inicializa el objeto de los argumentos extra
		this.argumentExtraSubmit={};
    	this.argumentExtraSubmit.id_tipo_equipo=this.maestro.id_tipo_equipo;
	},
	
	
	sortInfo:{
		field: 'id_equipo_variable',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
