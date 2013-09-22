<?php
/**
*@package pXP
*@file gen-UniCons.php
*@author  (admin)
*@date 05-02-2013 07:24:57
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniConsGralHijos=Ext.extend(Phx.gridInterfaz,{
	tam_pag:50,
	constructor:function(config){
		this.maestro=config;
		//console.log(this.maestro);
    	//llama al constructor de la clase padre
		Phx.vista.UniConsGralHijos.superclass.constructor.call(this,config);
		this.init();
		
		this.load({
			params: {
				start: 0,
				limit: 50,
				id_uni_cons: this.maestro.id_uni_cons
			}
		});
		
		//para definir atributos del equipo	
		this.addButton('btnAtrib', {
				text : '',
				iconCls : 'bchecklist',
				disabled : false,
				handler : this.onBtnAtribPlan,
				tooltip : '<b>Variables de Medición</b><br/>Define las variables del equipo'
		});
		
		this.addButton('btnUpload',{
           text :'',
           iconCls : 'bupload',
           disabled : false,
           handler : this.onButtonUpload,
           tooltip : '<b>Archivos</b><br/>Archivos del Equipo'
        });
        
        this.addButton('btnItems',{
            text : '',
            iconCls : 'bengine',
            disabled : false,
            handler : this.onButtonItems,
            tooltip : '<b>Repuestos/Proveedores</b><br/>Registro de Repuestos y Proveedores del Equipo'
        });
        
        this.addButton('btnDocTecnica', {
				text : '',
				iconCls : 'bdocuments',
				disabled : false,
				handler : this.onBtnDocTecnica,
				tooltip : '<b>Documentación Técnica</b><br/>Define la documentación técnica.'
		});
		
		this.addButton('btnOT', {
				text : '',
				iconCls : 'bdocuments',
				disabled : false,
				handler : this.onBtnOT,
				tooltip : '<b>Histórico de OITs</b><br/>Despliegue de todos los mantenimientos del Equipo seleccionado.'
		});
		
	},
			
	Atributos:[
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
			config:{
				name: 'incluir_calgen',
				fieldLabel: 'Incuido Plan.',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				renderer: function(value,p,record,otro, otro2){
					var result;
					if(value=='t'){
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/otros/tuc.png' align='center' width='18' height='18' title='Borrador'/></div>";
					} else{
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/otros/tucred.png' align='center' width='18' height='18' title='Revisado'/></div>";
					}
					return result;
				}
			},
			type:'Checkbox',
			filters:{	
	       		         type: 'list',
	       		         pfiltro: 'eqgral.incluir_calgen',
	       		         options: ['true', 'false']
	       		 	},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '100%',
				gwidth: 150,
				maxLength:150,
				disabled:true
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre Equipo',
				allowBlank: true,
				anchor: '100%',
				gwidth: 250,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_tipo_equipo',
				fieldLabel: 'Tipo Equipo',
				anchor: '80%',
				gwidth: 140,
				maxLength:4,
				renderer: function (value, p, record){
					return String.format('{0}', record.data['desc_tipo_equipo']);
				}
			},
			type:'Field',
			filters:{pfiltro:'nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name:'horas_dia',
				fieldLabel: 'Horas/Dia',
				anchor:'50%',
				gwidth:100
			},
			type:'NumberField',
			filters:{pfiltro:'eqgral.horas_dia',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'funcion',
				fieldLabel: 'Función',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextArea',
			filters:{pfiltro:'eqgral.funcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'otros_datos_tec',
				fieldLabel: 'Otros Datos Técnicos',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'eqgral.otros_datos_tec',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'punto_recepcion_despacho',
				fieldLabel: 'Punto Recepción/Despacho',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextArea',
			filters:{pfiltro:'eqgral.punto_recepcion_despacho',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'herramientas_especiales',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'eqgral.herramientas_especiales',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'Usuarios permitidos',
				fieldLabel: 'id_usuarios',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.id_usuarios',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_localizacion'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'tipo_unicons',
				fieldLabel: 'Tipo',
				anchor: '100%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'tuni_cons__tipo_unicons'
					}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'eqgral.tipo_unicons',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_plantilla',
				fieldLabel: 'Plantilla',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4,
				renderer: function (value, p, record){
					return String.format('{0}', record.data['desc_plantilla']);
				}
			},
			type:'NumberField',
			filters:{pfiltro:'nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
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
			filters:{pfiltro:'eqgral.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'tipo_nodo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'tipo'
			},
			type:'Field',
			form:true 
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
			filters:{pfiltro:'usr_reg',type:'string'},
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
			filters:{pfiltro:'fecha_reg',type:'date'},
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
			filters:{pfiltro:'usr_mod',type:'string'},
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
			filters:{pfiltro:'fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Equipos',
	ActSave:'../../sis_mantenimiento/control/UniCons/insertarUniConsGral',
	ActDel:'../../sis_mantenimiento/control/UniCons/eliminarUniConsGral',
	ActList:'../../sis_mantenimiento/control/UniCons/listarUniConsGralHijos',
	id_store:'id_uni_cons',
	fields: [
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'tipo_unicons', type: 'string'},
		{name:'id_plantilla', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'incluir_calgen', type: 'string'},
		{name:'otros_datos_tec', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'punto_recepcion_despacho', type: 'string'},
		{name:'tipo_nodo', type: 'string'},
		{name:'id_usuarios', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'herramientas_especiales', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'funcion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'localizaciones', type: 'string'},
		{name:'desc_tipo_equipo', type: 'string'},
		{name:'desc_plantilla', type: 'string'},
		{name:'horas_dia', type: 'numeric'}
		
	],
	sortInfo:{
		field: 'codigo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	bnew:false,
	loadValoresIniciales: function() {
		//console.log(this.maestro);
		Phx.vista.UniConsGralHijos.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
		this.getComponente('id_uni_cons').setValue(this.maestro.id_uni_cons);
	},
	onReloadPage: function(m) {
		//console.log(this.maestro)
		this.maestro=m;	
		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:this.tam_pag}});	
		
	},
	onBtnAtribPlan:function(){
		var rec=this.sm.getSelected();
		Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_variable/EquipoVariable.php',
			'Variables de Medición',
			{
				width:800,
				height:400
			},rec.data,this.idContenedor,'EquipoVariable')
		
		
	},
    onButtonUpload: function(){
       var rec=this.sm.getSelected();
       if(rec.data){
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_archivo/UniConsArchivo.php',
                               'Archivos de Unidades Constructoras',
                               {
                                   modal:true,
                                   width:900,
                                   height:500
                               },
                               rec.data,this.idContenedor,'UniConsArchivo');
           
       }  
    },
    onButtonItems: function(){
      var rec=this.sm.getSelected();
      if(rec.data){
          Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_item/UniConsItem.php',
          'Registro de items por equipo',{
              modal:true,
              width:900,
              height:400
          },
          rec.data,this.idContenedor,'UniConsItem');
      }  
    },
    onBtnDocTecnica: function() {
    	var rec=this.sm.getSelected();
            if(rec.data) {
            	Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_doc_tec/UniConsDocumentoTec.php',
                    'Documentacion Técnica',
                    {
                        modal:true,
                        width:700,
                        height:500
                    },
                    rec.data,this.idContenedor,'UniConsDocumentoTec')
            }
    },
    onBtnOT: function(){
      var rec=this.sm.getSelected();
      if(rec.data){
          Phx.CP.loadWindows('../../../sis_mantenimiento/vista/orden_trabajo/ListadoGeneralOT.php',
          'Histórico OITs: ['+rec.data.codigo+']',{
              modal:true,
              width:900,
              height:400
          },
          rec.data,this.idContenedor,'ListadoGeneralOT');
      }  
    },
    east:{
		  url:'../../../sis_mantenimiento/vista/uni_cons_det/UniConsDet.php',
		  title:'Atributos del Equipo', 
		  width:400,
		  cls:'UniConsDet'
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		