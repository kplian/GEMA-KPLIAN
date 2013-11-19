<?php
/**
*@package pXP
*@file gen-LocalizacionMed.php
*@author  (admin)
*@date 07-12-2012 14:20:30
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.LocalizacionMed=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.LocalizacionMed.superclass.constructor.call(this,config);
		
		this.dteFechaIni = new Ext.form.DateField({
			vtype: 'daterange',
		    name:  'startdt1',
		    format: 'd/m/Y',
		    allowBlank: false,
		    id: 'startdt'+this.idContenedor,
	        endDateField: 'enddt'+this.idContenedor,
	        width:103
		});
		this.dteFechaFin = new Ext.form.DateField({
		    vtype: 'daterange',
		    name: 'enddt1',
		    format: 'd/m/Y',
		    allowBlank: false,
	        id: 'enddt'+this.idContenedor,
	        startDateField: 'startdt'+this.idContenedor,
	        width:103
		});
		this.intDiasMes = new Ext.form.NumberField({
		 	name: 'numDias',
		 	allowBlank:false,
		 	width:35,
		 	value:7
		});
		this.limit = 1000;
		this.cmbLimit = new Ext.form.ComboBox({
	        store:[100,200,500,1000,5000,10000,20000,50000],
	        value:this.limit,
	        typeAhead: true,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText:'Tipo..',
	        selectOnFocus:true,
	        width:65
	    });
		
		this.dteFechaIni.on('change', this.updateDays, this);
		this.dteFechaFin.on('change', this.updateDays, this);
		
        this.getComponente('id_localizacion_orig').setValue(this.maestro.id_localizacion);
		//alert(this.getComponente('id_localizacion_orig').getValue())
		this.v_id_localizacion_orig=this.maestro.id_localizacion;
		
		this.addButton('btnInd', {
				text : '',
				iconCls : 'bstats',
				disabled : true,
				handler : this.onBtnInd,
				tooltip : '<b>Totales</b><br/>Muestra los valores totales de los indicadores en un periodo de tiempo definido.'
			});
		this.tbar.add('Desde: ',this.dteFechaIni);
	    this.tbar.add('Hasta: ',this.dteFechaFin);
	    this.tbar.add('Días: ',this.intDiasMes);
	    this.tbar.add('Limite: ',this.cmbLimit);
	    this.addButton('btnGrafica',{
            text : 'Graficar',
            iconCls : 'bgraph',
            disabled : false,
            handler : this.onButtonGrafica,
            tooltip : '<b>Gráfica</b><br/><b>Genera gráfica (La ordenación de los resultados afecta la gráfica)</b>'
             });
        this.getBoton('btnInd').enable();
		
		this.init();
		var milisegundos=parseInt(7*24*60*60*1000);
		var fechaActual = new Date();
		var fechaini  = new Date();
		fechaini.setTime(parseInt(fechaActual.getTime()-milisegundos));
		this.dteFechaIni.setValue(fechaini);
		this.dteFechaFin.setValue(fechaActual);
		
		this.store.baseParams={
			'id_localizacion':this.maestro.id_localizacion,
			fecha_ini:this.dteFechaIni.getValue().dateFormat('d/m/Y'),
			fecha_fin:this.dteFechaFin.getValue().dateFormat('d/m/Y') 
			};
		
		this.load({params:{
			start:0, 
			limit:this.limit
			}});
	},
	v_id_localizacion_orig:'',
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_localizacion_med'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_localizacion',
				inputType: 'hidden',
				labelSeparator: ''
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'id_localizacion_orig',
				inputType: 'hidden',
				labelSeparator: ''
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'fecha_med',
				fieldLabel: 'Fecha Medición',
				allowBlank: false,
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'locmed.fecha_med',type:'date'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'num_paros',
				fieldLabel: 'Nro. Paros No Planif.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 150,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.num_paros',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'num_paros_planif',
				fieldLabel: 'Nro. Paros Planif.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 150,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.num_paros_planif',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_op_hrs',
				fieldLabel: 'Operativo',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_op_hrs',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_standby_hrs',
				fieldLabel: 'Stand By',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_standby_hrs',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_uni_cons',
				fieldLabel: 'Equipo Stand by',
				allowBlank: true,
				emptyText:'Elija un equipo...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlano',
					id: 'id_uni_cons',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_uni_cons','codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'tuc.nombre'}
				}),
				valueField: 'id_uni_cons',
				displayField: 'nombre',
				gdisplayField:'desc_uni_cons',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth: 220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_uni_cons']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'locmed.desc_uni_cons',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_mnp_hrs',
				fieldLabel: 'MNP',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_mnp_hrs',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_mpp_hrs',
				fieldLabel: 'MPP',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_mpp_hrs',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				gwidth: 250,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'locmed.observaciones',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'locmed.estado_reg',type:'string'},
			id_grupo:0,
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'locmed.fecha_reg',type:'date'},
			id_grupo:0,
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
			id_grupo:0,
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
			id_grupo:0,
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'locmed.fecha_mod',type:'date'},
			id_grupo:0,
			grid:true,
			form:false
		}
	],
	title:'Mediciones',
	ActSave:'../../sis_mantenimiento/control/LocalizacionMed/insertarLocalizacionMed',
	ActDel:'../../sis_mantenimiento/control/LocalizacionMed/eliminarLocalizacionMed',
	ActList:'../../sis_mantenimiento/control/LocalizacionMed/listarLocalizacionMed',
	id_store:'id_localizacion_med',
	fields: [
		{name:'id_localizacion_med', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'id_localizacion_orig', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'tiempo_mnp_hrs', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tiempo_standby_hrs', type: 'numeric'},
		{name:'num_paros', type: 'numeric'},
		{name:'tiempo_op_hrs', type: 'numeric'},
		{name:'fecha_med', type: 'date', dateFormat:'Y-m-d'},
		{name:'tiempo_mpp_hrs', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_uni_cons', type: 'string'},
		{name:'observaciones', type: 'string'},
		{name:'num_paros_planif', type: 'numeric'}
	],
	sortInfo:{
		field: 'fecha_med',
		direction: 'ASC'
	},
	bdel:true,
	bsave: false,
	fwidth: 450,
	
	loadValoresIniciales:function(){
		Phx.vista.LocalizacionMed.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
		this.getComponente('id_localizacion_orig').setValue(this.maestro.id_localizacion);
	},	
	onReloadPage:function(m)
	{
		this.maestro=m;	
		this.limit = this.cmbLimit.getValue();					
		this.store.baseParams={id_localizacion:this.maestro.id_localización};
		this.load({params:{start:0, limit:this.limit}});			
	},
	Grupos:[{ 
		layout: 'column',
		items:[
			{
				xtype:'fieldset',
				layout: 'form',
                border: false,
                title: 'Tiempo en Horas',
                bodyStyle: 'padding:0px 10px;',
                columnWidth: 1,
                items:[],
		        id_grupo:0,
			}
			]
		}],
	east:{
		  url:'../../../sis_mantenimiento/vista/equipo_medicion/IndicadoresMediciones.php',
		  title:'Indicadores', 
		  //height:'50%',	//altura de la ventana hijo
		  width:'50%',		//ancho de la ventana hjo
		  cls:'IndicadoresMediciones'
	},
	/*south:{
		  url:'../../../sis_mantenimiento/vista/localizacion_med/Indicadores.php',
		  title:'Indicadores', 
		  height:'30%',	//altura de la ventana hijo
		  //params:{id_localizacion_orig:this.id_localizacion_orig},
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'IndicadoresGraf'
	},*/
	onButtonGrafica:function(){
		var rec = this.store.data.items;
	
		if(google&&google.visualization){
			var data = new google.visualization.DataTable();
			//Definición de las columnas
			data.addColumn('date', 'Fecha');
			data.addColumn('number','Operativo');
			data.addColumn('number','Stand By');
			data.addColumn('number','MNP');
			data.addColumn('number','MPP');
						
			//Cargado de los filas (valores por columnas). Se recorre todo el store para sacar los datos
			for (var i=0;i<rec.length;i++){
				var fila = [];
				fila[0]=rec[i].data['fecha_med'];
				fila[1]=isNaN(parseFloat(rec[i].data['tiempo_op_hrs']))?0:parseFloat(rec[i].data['tiempo_op_hrs']);
				fila[2]=isNaN(parseFloat(rec[i].data['tiempo_standby_hrs']))?0:parseFloat(rec[i].data['tiempo_standby_hrs']);
				fila[3]=isNaN(parseFloat(rec[i].data['tiempo_mnp_hrs']))?0:parseFloat(rec[i].data['tiempo_mnp_hrs']);
				fila[4]=isNaN(parseFloat(rec[i].data['tiempo_mpp_hrs']))?0:parseFloat(rec[i].data['tiempo_mpp_hrs']);
				//Se adiciona la fila al componente de visualización
			    data.addRow(fila)
			    	
			  }
			  //Dibuja o actualiza la gráfica
			  var pagIndicadores =  Phx.CP.getPagina(this.idContenedor+'-east');
			  if(pagIndicadores){
			     pagIndicadores.setDatachart(data);
		      }
	     }
	},
	onBtnInd:function(){
		//Verifica que se hayan introducido los valores a las variables para generación de los indicadores
		if(this.dteFechaIni.getValue()!=''&&this.dteFechaFin.getValue()!=''&&this.intDiasMes.getValue()!=''){
			var data={id_localizacion: this.v_id_localizacion_orig,
				num_dias: this.intDiasMes.getValue(),
				fecha_ini:this.dteFechaIni.getValue(),
				fecha_fin: this.dteFechaFin.getValue()
			};
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_med/Indicadores.php',
					'Estadísticas Indicadores',
					{
						width:600,
						height:300
				    },data,this.idContenedor,'IndicadoresGraf')	
		} else{
			//if(this.dteFechaIni.getValue()==''){
				this.dteFechaIni.isValid();
			//}
			//if(this.dteFechaFin.getValue()==''){
				this.dteFechaFin.isValid();
			//}
			//if(this.intDiasMes.getValue()==''){
				this.intDiasMes.isValid();
			//}
			Ext.MessageBox.alert('Alerta','Para generar los indicadores debe definir el Rango de Fechas y el Número de Días');
		}
	},
	updateDays: function(){
		var totalMillis = this.dteFechaFin.getValue().getTime() - this.dteFechaIni.getValue().getTime();
		var dias = totalMillis/(1000*60*60*24);
		this.intDiasMes.setValue(parseInt(dias)+1);
	},
	onButtonAct: function(){
		if(this.dteFechaIni.isValid() && this.dteFechaFin.isValid())
		{
			this.store.baseParams=Ext.apply(
				this.store.baseParams,{
					fecha_ini:this.dteFechaIni.getValue().dateFormat('d/m/Y'),
					fecha_fin:this.dteFechaFin.getValue().dateFormat('d/m/Y')})
			this.limit = this.cmbLimit.getValue();
			if(this.store.lastOptions){
			 //Phx.vista.EquipoMedicionDinamico.superclass.onButtonAct.call(this);
			 this.load({params:{start:0, limit:this.limit},callback:this.successReloadGrid,scope:this})
			}
			else{
				this.load({params:{start:0, limit:this.limit},callback:this.successReloadGrid,scope:this})
			}
		}
	},
	successReloadGrid:function(rec,con,res){
		
	},
    codReporte:'GMAN-RG-SM-028',
	codSistema:'GEM',
	pdfOrientacion:'L',
	title1:'REGISTRO',
	title2:'Indicadores de Mantenimiento'
})
</script>