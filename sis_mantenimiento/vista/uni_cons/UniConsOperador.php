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
Phx.vista.UniConsOperador=Ext.extend(Phx.gridInterfaz,{
	tam_pag:50,
	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.UniConsOperador.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		
		this.addButton('btnMed',{
           text :'',
           iconCls : 'bengine',
           disabled : true,
           handler : this.onClickMed,
           tooltip : '<b>Mediciones</b><br/>Registro de Mediciones de Operación'
        });
		
		this.addButton('btnUpload',{
           text :'',
           iconCls : 'bupload',
           disabled : true,
           handler : this.onButtonUpload,
           tooltip : '<b>Archivos</b><br/>Archivos del Equipo'
        });
        
        this.addButton('btnItems',{
            text : '',
            iconCls : 'bengine',
            disabled : true,
            handler : this.onButtonItems,
            tooltip : '<b>Repuestos/Proveedores</b><br/>Registro de Repuestos y Proveedores del Equipo'
        });
        
        this.addButton('btnDocTecnica', {
				text : '',
				iconCls : 'bdocuments',
				disabled : true,
				handler : this.onBtnDocTecnica,
				tooltip : '<b>Documentación Técnica</b><br/>Define la documentación técnica.'
		});
		
		this.addButton('btnSubsis', {
				text : '',
				iconCls : 'bchecklist',
				disabled : true,
				handler : this.onBtnSubsis,
				tooltip : '<b>Subistemas</b><br/>Subsistemas que componen al equipo'
		});
		
		this.addButton('btnFicTec',{
           text :'',
           iconCls : 'bpdf',
           disabled : true,
           handler : this.onFichaTecnicaClick,
           tooltip : '<b>Ficha Técnica</b><br/>Reporte Ficha Técnica en PDF'
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
					name: 'id_localizacion',
					fieldLabel: 'Localización',
					renderer:function (value, p, record){return String.format('{0}', record.data['desc_localizacion']);},
					gwidth:300
			},
			type:'TextField',
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
	ActList:'../../sis_mantenimiento/control/UniCons/listarUniConsOperador',
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
		{name:'horas_dia', type: 'numeric'},
		'desc_localizacion'
		
	],
	sortInfo:{
		field: 'codigo',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bnew:false,
	bedit:false,
    onButtonUpload: function(){
       var rec=this.sm.getSelected();
       if(rec){
	       if(rec.data){
	           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_archivo/UniConsArchivo.php',
	                               'Archivos de Unidades Constructoras',
	                               {
	                                   modal:true,
	                                   width:900,
	                                   height:500
	                               },
	                               rec.data,this.idContenedor,'UniConsArchivo');
	           
	       	} else{
				Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
			} 
       	} else{
			Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
		} 
    },
    onButtonItems: function(){
      var rec=this.sm.getSelected();
      if(rec){
	      if(rec.data){
	          Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_item/UniConsItem.php',
	          'Registro de items por equipo',{
	              modal:true,
	              width:900,
	              height:400
	          },
	          rec.data,this.idContenedor,'UniConsItem');
	      } else{
				Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
			}
      } else{
			Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
		}
    },
    onBtnDocTecnica: function() {
    	var rec=this.sm.getSelected();
    	if(rec){
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
		} else{
			Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
		}
    },
    onBtnSubsis: function() {
    	var rec=this.sm.getSelected();
    	if(rec){
            if(rec.data) {
            	Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons/UniConsGralHijos.php',
                    'Subsistemas',
                    {
                        modal:true,
                        width:700,
                        height:500
                    },
                    rec.data,this.idContenedor,'UniConsGralHijos')
            } else{
				Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
			}
        } else{
			Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
		}
    },
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	onClickMed: function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		if (data) {
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_medicion/EquipoMedicionDinamico.php', 'Mediciones: [' + data.codigo +' - '+data.nombre+']', {
				modal: true,
				width: '80%',
				height: '80%'
			}, data, this.idContenedor, 'EquipoMedicionDinamico')

		}
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.UniConsOperador.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnMed').setDisabled(false);
	  	this.getBoton('btnUpload').setDisabled(false);
	  	this.getBoton('btnItems').setDisabled(false);
	  	this.getBoton('btnDocTecnica').setDisabled(false);
	  	this.getBoton('btnSubsis').setDisabled(false);
	  	this.getBoton('btnFicTec').setDisabled(false);
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.UniConsOperador.superclass.liberaMenu.call(this);
	  	this.getBoton('btnMed').setDisabled(true);
	  	this.getBoton('btnUpload').setDisabled(true);
	  	this.getBoton('btnItems').setDisabled(true);
	  	this.getBoton('btnDocTecnica').setDisabled(true);
	  	this.getBoton('btnSubsis').setDisabled(true);
	  	this.getBoton('btnFicTec').setDisabled(true);
  		return tb;
	},
	onFichaTecnicaClick: function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		if (data) {
			Ext.Ajax.request({
				url: '../../sis_mantenimiento/control/UniCons/reporteUniConsFichaTecnica',
				params: {
					'id_uni_cons': data.id_uni_cons
				},
				success: this.successExport,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
		}
	}
})
</script>
		
		