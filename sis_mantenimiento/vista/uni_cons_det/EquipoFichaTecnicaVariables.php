<?php
/**
*@package pXP
*@file 
*@author  rcm
*@date 25-03-2012 10:27:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EquipoFichaTecnicaVariables=Ext.extend(Phx.gridInterfaz,{
	
	constructor:function(config){
		this.configMaestro=config;
		this.config=config;
    	Phx.CP.loadingShow();
    	
    	//Store para cargar las columnas dinámicas
	    this.storeAtributos= new Ext.data.JsonStore({
          			url:'../../sis_mantenimiento/control/UniConsDet/listarColumnasFichaTecVar',
				    id: 'id',
   					root: 'datos',
   				    totalProperty: 'total',
   					fields: ['id','nombre','key']/*,
						sortInfo:{
							field: 'id',
							direction: 'ASC'
						}*/
						});
		//evento de error
		this.storeAtributos.on('loadexception',this.conexionFailure);				

		this.storeAtributos.load({params:{
			                              "sort":"id",
			                              "dir":"ASC",
			                              id_localizacion: config.id_localizacion,
			                              id_uni_cons: config.id_uni_cons,
			                              id_tipo_equipo: this.config.id_tipo_equipo,
			                              //'id_uni_cons':config.id_uni_cons,
			                               start:0, 
			                               limit:500
			                     	},callback:this.successConstructor,
			                     	scope:this
		})
	},		
	
	successConstructor:function(rec,con,res){
		this.recColumnas = rec;
		this.Atributos=[];
		this.fields=[];
		this.id_store='id_reporte';
		
		this.sortInfo={
			field: 'fecha,ucons.codigo',
			direction: 'ASC'
		};
		
		this.fields.push(this.id_store);
		this.fields.push('id_localizacion');
		this.fields.push('id_uni_cons');
		this.fields.push({name:'fecha', type: 'date', dateFormat:'Y-m-d'});
		this.fields.push('equipo');
		this.fields.push('desc_localizacion');
		
		if(res){
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
										name: 'equipo',
										fieldLabel: 'Equipo',
										allowBlank: false,
										anchor: '100%',
										gwidth:250
								},
								type:'TextField',
								//filters:{pfiltro:'fecha',type:'date'},
								grid:true,
								form:false 
						};
						
			this.Atributos[2]={
			//configuracion del componente
								config:{
										name: 'desc_localizacion',
										fieldLabel: 'Localizacion',
										allowBlank: false,
										anchor: '100%',
										gwidth:250
								},
								type:'TextField',
								//filters:{pfiltro:'fecha',type:'date'},
								grid:true,
								form:false 
						};
			
									
			var recText = 'equipo#varchar@'+this.id_store +'#integer@id_uni_cons#integer@desc_localizacion#varchar';			
			
			for (var i=0;i<rec.length;i++){
				var configDef={};
				var codigo_col = 'col_'+rec[i].data.key;
				
				this.fields.push(codigo_col);
				this.fields.push(codigo_col+'_key');
				
			    recText=recText+'@'+codigo_col+'_key#varchar'+'@'+codigo_col+'#varchar'
				
				this.Atributos.push({config:{
									 name: codigo_col,
									 fieldLabel: rec[i].data.nombre,
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 180,
									 maxLength:100
									},
									type:'NumberField',
									filters:{pfiltro:rec[i].data.codigo_columna,type:'string'},
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});
							
				
				
				this.Atributos.push({config:{
									 name: codigo_col+'_key',
									 inputType:'hidden'
									},
									type:'Field',
									form:true
							});
					
			}
			
			Phx.CP.loadingHide();
			Phx.vista.EquipoFichaTecnicaVariables.superclass.constructor.call(this,this.config);
			this.argumentExtraSubmit={
				'id_localizacion':this.config.id_localizacion,
				'id_tipo_equipo':this.config.id_tipo_equipo,
				'datos':recText,
				'id_uni_cons':this.config.id_uni_cons
			};
		    
		//Agrega eventos a los componentes creados
		this.cmb_caract.on('select',function (combo, record, index){
			//Verifica que el campo de texto tenga algun valor
			if(Ext.util.Format.trim(this.txt_caract.getValue())!=''){
				this.store.baseParams.nombre_caract=Vcmb_caract.getValue();
				this.store.baseParams.valor_caract=Vtxt_caract.getValue();	
				this.store.load({params:{start:0, limit:this.tam_pag}});	
			} else{
				this.store.baseParams.nombre_caract='';
				this.store.baseParams.valor_caract='';
				this.store.load({params:{start:0, limit:this.tam_pag}});
			}
		},this);
		
		this.cmb_caract.store.on('exception', this.conexionFailure);
		
		this.txt_caract.on('blur',function (combo, record, index){
			//Verifica que el campo de texto tenga algun valor
			if(Ext.util.Format.trim(this.cmb_caract.getValue())!=''){
				this.store.baseParams.nombre_caract=this.cmb_caract.getValue();
				this.store.baseParams.valor_caract=this.txt_caract.getValue();	
				this.store.load({params:{start:0, limit:this.tam_pag}});
			} else{
				this.store.baseParams.nombre_caract='';
				this.store.baseParams.valor_caract='';
				this.store.load({params:{start:0, limit:this.tam_pag}});
			}
		},this);

		    this.tbar.add('Desde: ',this.dateFechaIni);
		    this.tbar.add('Hasta: ',this.dateFechaFin);
		    this.tbar.add('Limite: ',this.cmbLimit);
		    //Agrega los botones a la barra de herramientas
			//this.tbar.add(this.cmb_caract);
			//this.tbar.add(this.txt_caract);
		    
		
		    /*this.addButton('btnGrafica',{
            text : 'Graficar',
            iconCls : 'bgraph',
            disabled : false,
            handler : this.onButtonGrafica,
            tooltip : '<b>Gráfica</b><br/><b>Genera gráfica (La ordenación de los resultados afecta la gráfica)</b>'
             });*/
        
		
			this.init();
			
					                   
			var milisegundos=parseInt(7*24*60*60*1000);
			var fechaActual = new Date();
			var fechaini  = new Date();
			fechaini.setTime(parseInt(fechaActual.getTime()-milisegundos));
 
           
			this.dateFechaIni.setValue(fechaini);
			this.dateFechaFin.setValue(fechaActual);
			
			this.store.baseParams={
				'id_localizacion':this.config.id_localizacion,
				'id_tipo_equipo':this.config.id_tipo_equipo,
				'datos':recText,
				fecha_ini:this.dateFechaIni.getValue().dateFormat('d/m/Y'),
				fecha_fin:this.dateFechaFin.getValue().dateFormat('d/m/Y'),
				id_uni_cons:this.config.id_uni_cons
			};			               
		
            this.load();
		}
		
	},
	onButtonGrafica:function(){
		
		var rec = this.store.data.items;
	
		if(google&&google.visualization){
			var data = new google.visualization.DataTable();
			//adciona columnas
			//data.addColumn('string', 'nombre');
			data.addColumn('datetime', 'Fecha');
			//data.addColumn('timeofday', 'Hora');
			for (j=0;j<this.recColumnas.length ;j++){
				data.addColumn('number', this.recColumnas[j].data.nombre_tipo_variable);
						
			}
			for (var i=0;i<rec.length;i++){
				var fila = [];
			    
			   // fila[0]='prueba';
			    //fila[0]=rec[i].data['fecha'].dateFormat('d/m/Y')+' '+rec[i].data['hora']
			    var time=rec[i].data['hora'].split(":");
			    rec[i].data['fecha'].setHours(time[0],time[1],time[2],0);
			    
			    fila[0]=rec[i].data['fecha'];
			   
			
			    
			    for (j=0;j<this.recColumnas.length;j++){
			        var codigo_col = 'col_'+this.recColumnas[j].data.key;
				    var aux = parseFloat(rec[i].data[codigo_col]);
				    fila[j+1]=aux?aux:0;
			      }
			     data.addRow(fila);
			  }
			  var pagIndicadores =  Phx.CP.getPagina(this.idContenedor+'-east');
			  if(pagIndicadores){
			     pagIndicadores.setDatachart(data);
		      }
	     }
	},
	
	onButtonAct:function(){
		if(this.dateFechaIni.isValid() && this.dateFechaFin.isValid())
		{
			this.store.baseParams=Ext.apply(this.store.baseParams,{fecha_ini:this.dateFechaIni.getValue().dateFormat('d/m/Y'),
			fecha_fin:this.dateFechaFin.getValue().dateFormat('d/m/Y'),
			id_tipo_equipo:this.config.id_tipo_equipo})
			
			this.limit = this.cmbLimit.getValue();
		 	this.load({params:{start:0, limit:this.limit},callback:this.successReloadGrid,scope:this})
			
		}
		
	},
	
	successReloadGrid:function(rec,con,res){

		
	},
	
	onButtonDel:function(){
		
	},
	
	title:'Detalle Consolidación de Mediciones por Localización',
	ActSave:'../../sis_mantenimiento/control/EquipoMedicion/insertarEquipoMedicionDinamico',
	ActDel:'../../sis_mantenimiento/control/EquipoMedicion/eliminarEquipoMedicionDinamico',
	ActList:'../../sis_mantenimiento/control/UniConsDet/listarFichaTecnicaVariables',
	bdel:false,
	bsave:false,
	bnew:false,
	bedit:false,
	fwidth: 450,
	cmbLimit:new Ext.form.ComboBox({
	        store:[100,200,500,1000,5000,10000,20000,50000],
	        value:1000,
	        typeAhead: true,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText:'Tipo..',
	        selectOnFocus:true,
	        width:135
	    }),
				
	onReloadPage:function(m)
	{
		this.maestro=m;	
		this.limit = this.cmbLimit.getValue();					
		this.store.baseParams={
			id_localizacion:this.maestro.id_localizacion,
			id_tipo_equipo:this.maestro.id_tipo_equipo,
			id_uni_cons:this.maestro.id_uni_cons
		};
		this.load({params:{start:0, limit:this.limit}});			
	},
	dateFechaIni:new Ext.form.DateField({
		      
	          vtype: 'daterange',
	          name:  'startdt',
	          format: 'd/m/Y',
	          allowBlank: false,
             id: 'startdt'+this.idContenedor,
              endDateField: 'enddt'+this.idContenedor
	         	
	    }),
	 dateFechaFin:new Ext.form.DateField({
		    
	         vtype: 'daterange',
	         name: 'enddt',
	         format: 'd/m/Y',
	         allowBlank: false,
             id: 'enddt'+this.idContenedor,
             startDateField: 'startdt'+this.idContenedor
	         	
	    }),  

	//Aumenta campos para filtro por caracteristicas
	cmb_caract: new Ext.form.ComboBox({
			name:'cmb_caract',
			fieldLabel:'Características',
			allowBlank:true,
			emptyText:'Elija una característica...',
			store: new Ext.data.JsonStore({
  			url: '../../sis_mantenimiento/control/UniConsDet/listarCaract',
				id: 'id_uni_cons_det',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['nombre'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'nombre'}
			}),
			valueField: 'nombre',
			displayField: 'nombre',
			forceSelection:true,
			typeAhead: false,
			triggerAction: 'all',
			lazyRender:true,
			mode:'remote',
			pageSize:10,
			queryDelay:1000,
			minChars:2,
			width:180,
			listWidth:300
		}),
		txt_caract: new Ext.form.TextField({
			name: 'txt_caract',
			fieldLabel: 'Valor',
			allowBlank:true,
			emptyText:'Defina el valor de la característica...',
			width: 200
		}),
		south:{
			  url:'../../../sis_mantenimiento/vista/uni_cons_det/UniConsDet.php',
			  title:'Atributos del Equipo', 
			  height:200,
			  cls:'UniConsDet'
		 },
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	title1:'Formulario',
	title2:'Detalle Operativo de Vehículos',
	addMaestro: function(data){
		var obj=Phx.vista.EquipoFichaTecnicaVariables.superclass.addMaestro.call(this,data);
		obj.push({ 
	   	    label:'Fecha Inicio',
			name:'fecha_desde',
			width:100,
			type:'string',
			gdisplayField:'Fecha Inicio',
			value:this.dateFechaIni.getValue().dateFormat('d/m/Y')
		});
		obj.push({ 
	   	    label:'Fecha Fin',
			name:'fecha_hasta',
			width:100,
			type:'string',
			gdisplayField:'Fecha Hasta',
			value:this.dateFechaFin.getValue().dateFormat('d/m/Y')
		});
		return obj;
	},
	repFilaInicioEtiquetas:35,
	repFilaInicioDatos:6.5,
	desplegarMaestro:'si',
	title1:'REGISTRO',
	title2:'Detalle Operativo de Vehículos',
	codReporte:'GMAN-RG-SM-007',
	codSistema:'GEM',
	pdfOrientacion:'L'	
})
</script>
		
		
