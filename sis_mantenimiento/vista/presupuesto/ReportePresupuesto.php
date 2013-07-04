<?php
/**
*@package pXP
*@file RerportePresupuesto
*@author  rcm
*@date 04/07/2013
*@description Archivo con la interfaz que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PresupuestoRep=Ext.extend(Phx.gridInterfaz,{
     constructor:function(config){
		this.configMaestro=config;
		this.config=config;
    	//llama al constructor de la clase padre
    	Phx.CP.loadingShow();
   
   		//Definción de cantidad de meses a reportar 	
    	this.cantMeses=config.mes_fin - config.mes_ini + 1;
    	
    	//Construcción del gri dinámico
   		this.construirGrid();
	},
	cantMeses:0,		
	
	construirGrid:function(rec,con,res){
		
		//this.recColumnas = rec;
		this.Atributos=[];
		this.fields=[];
		this.id_store='id_localizacion'
		
		this.sortInfo={
			field: 'id_localizacion',
			direction: 'ASC'
		};
		this.fields.push(this.id_store)
		this.fields.push('localizacion')

			this.Atributos[0]={
				config:{
						labelSeparator:'',
						inputType:'hidden',
						name: this.id_store
				},
				type:'Field',
				form:true 
			};
			
			this.Atributos[1]={
				config:{
						
						name: 'localizacion',
						fieldLabel: 'Localización',
						allowBlank: true,
						anchor: '100%'
				},
				type:'Field',
				filters:{pfiltro:'localizacion',type:'string'},
				grid:true,
				form:true 
			};
			
			//Variable de las columnas a recibir de la base de datos								
			var recText = this.id_store +'#integer@localizacion#varchar';			
			
			for (var i=1;i<=this.cantMeses;i++){
				var configDef={};
				
				var codigo_col1 = 'monto_prog_'+i;
				var codigo_col2 = 'monto_techo_'+i;
				var codigo_col3 = 'porcen_prog_techo_'+i;
				var codigo_col4 = 'monto_presup_'+i;
				var codigo_col5 = 'monto_ejec_'+i;
				var codigo_col6 = 'porcen_presup_ejec_'+i;
				
				this.fields.push(codigo_col1);
				this.fields.push(codigo_col2);
				this.fields.push(codigo_col3);
				this.fields.push(codigo_col4);
				this.fields.push(codigo_col5);
				this.fields.push(codigo_col6);
				
			    recText=recText+'@'+codigo_col1+'#numeric@'+codigo_col2+'#numeric@'+codigo_col3+'#numeric@'+codigo_col4+'#numeric@'+codigo_col5+'#numeric@'+codigo_col6+'#numeric@';
				
				this.Atributos.push({config:{
									 name: codigo_col1,
									 fieldLabel: 'Monto Prog.',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});
				this.Atributos.push({config:{
									 name: codigo_col2,
									 fieldLabel: 'Monto Techo',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});
				
				this.Atributos.push({config:{
									 name: codigo_col3,
									 fieldLabel: '%Prog. Techo',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});
							
				this.Atributos.push({config:{
									 name: codigo_col4,
									 fieldLabel: 'Monto Presup.',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});
							
				this.Atributos.push({config:{
									 name: codigo_col5,
									 fieldLabel: 'Monto Ejec.',
									 allowBlank: true,	
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});
							
				this.Atributos.push({config:{
									 name: codigo_col6,
									 fieldLabel: '% Presup./Ejec..',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									id_grupo:1,
									egrid:false,
									grid:true,
									form:true
							});	
			}
			
			Phx.CP.loadingHide();
			Phx.vista.PresupuestoRep.superclass.constructor.call(this,this.config);
			this.argumentExtraSubmit={'id_localizacion':this.config.id_localizacion,'datos':recText};

		    this.addButton('btnGrafica',{
            text : 'Graficar',
            iconCls : 'bgraph',
            disabled : false,
            //handler : this.onButtonGrafica,
            tooltip : '<b>Gráfica</b><br/><b>Genera gráfica (La ordenación de los resultados afecta la gráfica)</b>'
             });

			this.init();
			this.store.baseParams={'id_presupuesto':this.config.id_presupuesto,'datos':recText,mes_ini:this.config.mes_ini,mes_fin:this.config.mes_fin};			               
            this.load();
	},
	successReloadGrid:function(rec,con,res){

		
	},
	title:'Mediciones del Equipo',
	ActSave:'../../sis_mantenimiento/control/EquipoMedicion/insertarEquipoMedicionDinamico',
	ActDel:'../../sis_mantenimiento/control/EquipoMedicion/eliminarEquipoMedicionDinamico',
	ActList:'../../sis_mantenimiento/control/EquipoMedicion/listarEquipoMedicionDinamico',
	bdel:false,
	bsave:false,
	bnew:false,
	bedit:false,
	fwidth: 450,
	onReloadPage:function(m)
	{
		this.maestro=m;	
		this.limit = this.cmbLimit.getValue();					
		this.store.baseParams={id_presupuesto:this.maestro.id_presupuesto};
		this.load({params:{start:0, limit:this.limit}});			
	},

    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	desplegarMaestro:'si',
	repFilaInicioEtiquetas:35,
	repFilaInicioDatos:6.5 
})
</script>
		
		