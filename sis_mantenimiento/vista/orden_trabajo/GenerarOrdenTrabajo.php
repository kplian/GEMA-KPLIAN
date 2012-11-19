<?php
/**
*@package pXP
*@file gen-TipoSensor.php
*@author  (mflores)
*@date 15-03-2012 10:27:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script> 
Phx.vista.GenerarOrdenTrabajo=Ext.extend(Phx.gridInterfaz, {
     constructor: function(config) {
		
		Ext.apply(this, config);
		this.panel = Ext.getCmp(this.idContenedor);
		
		this.configMaestro=config;
		this.config=config;
		
		this.storeAtributos= new Ext.data.JsonStore({
			url:'../../sis_mantenimiento/control/CalendarioPlanificado/listarOrdenesDeTrabajoGenerados',
		    //id: 'id_sem_mes',
			root: 'datos',
		    //totalProperty: 'total',
			fields: ['equipo','mes','semana','codigo'],
				sortInfo:{
					field: 'id_sem_mes',
					direction: 'ASC'
			}
		});
		
		//evento de error
		this.storeAtributos.on('loadexception',this.conexionFailure);				
		
// 			
			// //ventana para modificar fecha
// 			
			  // this.formCP2 = new Ext.form.FormPanel({
		        // //baseCls: 'x-plain',
		        // id: this.idContenedor + '_FCP2',
		        // bodyStyle: 'padding:10 20px 10;',
		        // autoDestroy: true,
		        // // border: false,
                    // // title: 'Checkbox Groups',
                    // //autowidth: true,
               // //  layout: 'form',
// 		      
		        // autoScroll: true,
// 		       
		        // items: [{
						// xtype: 'datefield',
// 						
						// name: 'cp2_fecha_ini',
						// fieldLabel: 'Inicia',
						// format:'d-m-Y',
						// allowBlank: false,
						// allowBlank: false				
					// },
					// {
		                // xtype: 'checkbox',
		                // checked: true,
		                // fieldLabel: '',
		                // labelSeparator: '',
		                // boxLabel: 'Recorrer los mantenimientos siguientes',
		                // name: 'recursivo'
		            // },
		            // {
		                // xtype: 'field',
		                // fieldLabel: '',
		                // inputType:'hidden',
		                // labelSeparator: '',
		                // name: 'id_calendario_plan'
		            // }]
		    // });
// 		    
// 		  
		     // this.wCP2 = new Ext.Window({
// 		     	
                    // id: this.idContenedor + '_WCP2',
//                    
                    // //autoEl:this.idContenedor,
                    // //autoLoad:false,
                   // //border: false,
                    // // title: 'Checkbox Groups',
                    // //autowidth: true,
                    // layout: 'fit',
// 		     	
// 		     	
// 		     
		        // collapsible: true,
		        // maximizable: true,
		         // autoDestroy: true,
		        // width: 400,
		        // height: 350,
		       // //layout: 'form',
		        // //plain: true,
// 		        
		        // //buttonAlign: 'center',
		        // items: this.formCP2,
		        // //modal:false,
		        // //autoShow:true,
		        // closeAction: 'hide',
		        // buttons: [{
		            // text: 'Guardar',
		             // handler:this.onUpdateCP,
		            // scope:this
// 		            
		        // },{
		            // text: 'Cancelar',
		            // handler:function(){this.wCP2.hide()},
		            // scope:this
		        // }]
		    // });
//     	
	    
        //crea una ventana de parametrizacion de fechas
        
	    this.formDefinirFechasOT = new Ext.form.FormPanel({
        	bodyStyle: 'padding:10 20px 10;',
	        autoDestroy: true,
	        border: false,
            layout: 'form',
	        autoScroll: true,
	        defaults: {
	            xtype: 'textfield'
	        },
	        items: [
	        	{
					xtype: 'datefield',
					name: 'fecha_ini',
					fieldLabel: 'Inicio',
					format:'d-m-Y',
					allowBlank: false,
					allowBlank: false				
				}, {
					xtype: 'datefield',
					name: 'fecha_fin',
					fieldLabel: 'Fin',
					format:'d-m-Y',
					allowBlank: false,	
					allowBlank: false					
				}
			]
	    });
		    
		this.dialogDefinirFechasOT = new Ext.Window({
		    border: false,
            layout: 'fit',
		    collapsible: true,
		    maximizable: true,
		    autoDestroy: true,
		    width: 400,
		    height: 350,
	        plain: true,
	        
	        buttonAlign: 'center',
	        items: this.formUCCL,
	        modal:true,
	        closeAction: 'hide',
	        buttons: [{
	            text: 'Guardar',
	            handler: this.generarOT,
	            scope:this
	            
	        }, {
	            text: 'Cancelar',
	            handler: function(){
	            	this.wUCCL.hide();
	            	this.panel.close();
	          	},
	            scope:this
	        }]
	    });
      	this.dialogDefinirFechasOT.show(); 
	},
	
	CellSelectionModel: true,
	
	generarOT: function() {
		if (this.formDefinirFechasOT.getForm().isValid()) {
		Phx.CP.loadingShow();
		var dateFechaIni = this.formDefinirFechasOT.getForm().findField('fecha_ini');
		var dateFechaFin = this.formDefinirFechasOT.getForm().findField('fecha_fin');
		
		//suponemos que no hay mas de 50 meses
		this.storeAtributos.load({
			 params:{
			     fecha_ini: dateFechaIni.getValue().dateFormat('d-m-Y'),
			     fecha_fin: dateFechaFin.getValue().dateFormat('d-m-Y'),
	             start:0,
	             limit:450
	             },
             callback: this.successConstructor,
             scope: this
             }
         )}
	},
	successConstructor: function(rec,con,res) {
		console.log(rec);
		console.log(con);
		console.log(res);
		this.Atributos = [];
		this.fields = [];
		this.id_store = 'id_sem_mes'
		this.sortInfo = {
			field: 'nombre_uni_cons',
			direction: 'ASC'
		};
		this.fields.push(this.id_store)
		this.fields.push('id_uni_cons')
		this.fields.push('id_mant_predef')
		this.fields.push('nombre_uni_cons')
		this.fields.push('nombre_mant')
		this.fields.push('codigo_man')
		
		if(res)
		{
			this.Atributos[0]={
			//configuracion del componente
								config:{
										labelSeparator:'',
										inputType:'hidden',
										name: this.id_store
								},
								type:'Field',
								form:true 
						};
			
			this.Atributos[1]={
			//configuracion del componente
								config:{
										labelSeparator:'',
										inputType:'hidden',
										name: 'id_uni_cons'
								},
								type:'Field',
								form:true 
						};
						
			this.Atributos[2]={
			//configuracion del componente
								config:{
										labelSeparator:'',
										inputType:'hidden',
										name: 'id_mant_predef'
								},
								type:'Field',
								form:true 
						};
			
			this.Atributos[3]={
			//configuracion del componente
								config:{
										
										name: 'nombre_uni_cons',
										fieldLabel: 'Equipo'
								},
								type:'Field',
								filters:{pfiltro:'nombre_uni_cons',type:'string'},
								grid:true,
								form:false 
						};
						
			this.Atributos[4]={
			//configuracion del componente
								config:{
										
										fieldLabel: 'Mantenimiento',
										name: 'nombre_mant',
										gwidth:200 ,
								},
								type:'Field',
								filters:{pfiltro:'nombre_mant',type:'string'},
								grid:true,
								form:false 
						};	
						
			var mesesGroups = [];	
			
			 mesesGroups.push({
                    header: 'E/M',
                    colspan: 3,
                    align: 'center'
                });					 		
						
			var recText = this.id_store + '#integer@id_uni_cons#integer@id_mant_predef#integer@nombre_uni_cons#varchar@nombre_mant#varchar@codigo_man#varchar';			
				//console.log('this.id_store: ', this.id_store);		
			
			for (var i=0;i<rec.length;i++){
				var configDef={};
				
				if(rec[i].data.semana=='s1'){
					mesesGroups.push({
	                    header: rec[i].data.mes+'/'+rec[i].data.ano,
	                    colspan: 4,
	                    align: 'center'
	                });	
                }
				
					
				this.fields.push(rec[i].data.codigo);
				this.fields.push('cp_'+rec[i].data.codigo);
				
				
			    recText=recText+'@'+rec[i].data.codigo+'#varchar@cp_'+rec[i].data.codigo+'#int4'
				
				
				this.Atributos[i+5]={config:{
									 name: rec[i].data.codigo,
									 fieldLabel: rec[i].data.semana,
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 25,
									 maxLength:100,
									 sortable:false,
									  renderer:function (value, p, record){
										if(value=='1'){
										
												return "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_green.png' align='center' width='18' height='18'/></div>"
									   		}
										}
									 
									},
									type:'Field',
									id_grupo:1,
									filters:{pfiltro:rec[i].data.codigo,type:'string'},
									egrid:false,
									grid:true,
									form:false
							};
					
			}
			this.wUCCL.hide();
			
			
			
			 this.plugingGroup = new Ext.ux.grid.ColumnHeaderGroup({
                 rows: [mesesGroups]
               });
			
			
			//creamos una ventana para modificacion 
			//de fecha de mantenimiento de fecha de mantenimiento
			//puede servir para insertar tambien
			
			
			
			Phx.CP.loadingHide();
			Phx.vista.gridCalendario.superclass.constructor.call(this,this.config);
			
			 var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
		     var dateFechaFin =this.formUCCL.getForm().findField('fecha_fin');
			
			this.argumentExtraSubmit={
				fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
		        fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y')};
		    
			
			
		
			this.init();
			
			
			
			var id_l = (this.tipo_nodo=='uni_cons')?this.id_uni_cons:this.id_localizacion;
			
			this.store.baseParams={
				fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
		        fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y'),
		        tipo_nodo:this.tipo_nodo,
		        id_localizacion:id_l,
				datos:recText};			               
				                   
			this.load({params:{start:0, limit:50}})
			
		}
		
	},
	
	
	
	
	
		
	
	
	title:'Calendario de Planificacion',
	ActSave:'../../sis_hidrologia/control/TipoSensorCodigo/insertarTipoSensorCodigo',
	ActDel:'../../sis_hidrologia/control/TipoSensorCodigo/eliminarTipoSensorCodigo',
	ActList:'../../sis_mantenimiento/control/CalendarioPlanificado/listarCalendarioPlanificadoDet',
	bdel:false,
	bsave:false,
	bnew:false,
	bedit:false,
	preparaMenu:function(tb){
			Phx.vista.gridCalendario.superclass.preparaMenu.call(this,tb)
			return tb
		},
	liberaMenu:function(tb){
			Phx.vista.gridCalendario.superclass.liberaMenu.call(this,tb)
			return tb
		},
	loadValoresIniciales:function()
	{
		Phx.vista.gridCalendario.superclass.loadValoresIniciales.call(this);
		//this.getComponente('id_sensor').setValue(this.config.id_sensor);	
			
	},
				
	onReloadPage:function(m)
	{
		this.maestro=m;						
		//this.store.baseParams={id_sensor:this.maestro.id_sensor};
		this.load({params:{start:0, limit:50}});			
	}
	,
	
	EnableSelect:function(n,b,c){
		
		console.log(n,b,c)
		console.log(n.getSelectedCell())
		
		//recuperar datos
		
		var record = this.store.getAt(b);
		var valcol = this.cm.getDataIndex(c);
		var cp_val= 'cp_'+valcol;
		
		console.log(valcol,cp_val, record.data[valcol], record.data[cp_val] ,record.data['cp_november_2012_s1'])
		
		//llamada para cargar dattos del mantenimiento
		if(record.data[valcol]=='1'){
			Phx.CP.loadingShow();
			Ext.Ajax.request({
			                    form: this.form.getForm().getEl(),
			                    url: '../../sis_mantenimiento/control/CalendarioPlanificado/OtenerCalPla',
			                    params: {
			                         	calendario_planificado: record.data[cp_val]
			                         	},		                    	
			                    success: this.successObtCalPlan,
			                    failure:this.conexionFailure,
			                    timeout: this.timeout,
			                    scope: this
			               });
		}
       },
       successObtCalPlan:function(r){
       	Phx.CP.loadingHide();
		this.wCP2.show(); 
		console.log(r)
		
		 var regreso = Ext.util.JSON.decode(Ext.util.Format.trim(r.responseText));
		 
		if(!regreso.ROOT.error){
			console.log(regreso.ROOT.datos)
			
			var cpFechaIni =this.formCP2.getForm().findField('cp2_fecha_ini');
			var cpIdCal =this.formCP2.getForm().findField('id_calendario_plan');
			
			
			cpIdCal.setValue(regreso.ROOT.datos.id_calendario_planificado);
			cpFechaIni.setValue(regreso.ROOT.datos.fecha_ini);
			
		}
		else{
			alert('Error al recuperar las fecha desde la base de datos')
			
		}
		
		
	   },
	   
	   onUpdateCP:function(){
	   	
	   	if (this.formCP2.getForm().isValid()) {
		
			Phx.CP.loadingShow();
			
			 var cpFechaIni =this.formCP2.getForm().findField('cp2_fecha_ini');
			 var ckRecursivo =this.formCP2.getForm().findField('recursivo');
			 var idCalPlan =this.formCP2.getForm().findField('id_calendario_plan');
			 
			 Ext.Ajax.request({
		                    form: this.form.getForm().getEl(),
		                    url: '../../sis_mantenimiento/control/CalendarioPlanificado/UpdateCalPla',
		                    params: {
		                         	fecha_ini:cpFechaIni.getValue().dateFormat('d-m-Y'),
			                        recursivo:ckRecursivo.getValue(),
			                        id_calendario_planificado:idCalPlan.getValue()
		                         	},		                    	
		                    success: this.successUpdateCalPlan,
		                    failure:this.conexionFailure,
		                    timeout: this.timeout,
		                    scope: this
		               });
			 
	   	}
	   },
	   
	   successUpdateCalPlan:function(resp){
	   	Phx.CP.loadingHide();
	   	this.wCP2.hide(); 
	   	this.reload();
	   	
	   },
	   
	     onDestroy: function(c) {
	     	
	     	this.formUCCL.destroy();
	     	this.wUCCL.destroy();
       
        if (this.wCP2) {
            this.wCP2.destroy();
            
        }
        if (this.formCP2) {
            this.formCP2.destroy();
        }

        
        
        Phx.vista.gridCalendario.superclass.onDestroy.call(this,c);

    },
        	
		
   }

)
</script>
		
		