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
		this.init();
		this.load({params:{start:0, limit:50, id_localizacion:this.maestro.id_localizacion}})
		this.tbar.add('Desde: ',this.dteFechaIni);
	    this.tbar.add('Hasta: ',this.dteFechaFin);
	    this.tbar.add('Días: ',this.intDiasMes);
	    this.addButton('btnGrafica',{
            text : 'Graficar',
            iconCls : 'bstatistics',
            disabled : false,
            handler : this.onButtonGrafica,
            tooltip : '<b>Gráfica</b><br/><b>Genera gráfica (La ordenación de los resultados afecta la gráfica)</b>'
             });
	},
			
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
				name: 'fecha_med',
				fieldLabel: 'Fecha Medición',
				allowBlank: false,
				anchor: '80%',
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
				fieldLabel: 'Nro. Paros',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
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
				name: 'tiempo_op_hrs',
				fieldLabel: 'Operativo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_op_hrs',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_standby_hrs',
				fieldLabel: 'Stand By',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_standby_hrs',type:'numeric'},
			id_grupo:1,
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
					baseParams:{par_filtro:'nombre'}
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
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_mnp_hrs',
				fieldLabel: 'MNP',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_mnp_hrs',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_mpp_hrs',
				fieldLabel: 'MPP',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'locmed.tiempo_mpp_hrs',type:'numeric'},
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
			filters:{pfiltro:'locmed.estado_reg',type:'string'},
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
			filters:{pfiltro:'locmed.fecha_reg',type:'date'},
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
			filters:{pfiltro:'locmed.fecha_mod',type:'date'},
			id_grupo:1,
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
		{name:'desc_uni_cons', type: 'string'}
		
	],
	sortInfo:{
		field: 'fecha_med',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.LocalizacionMed.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
	},	
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_localizacion:this.maestro.id_localizacion};
		this.load({params:{start:0, limit:50}});			
	},
	Grupos:[{ 
		layout: 'column',
		items:[
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: '',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: '.5',
                items:[],
		        id_grupo:0,
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Tiempo en Horas',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: '.5',
                items:[],
		        id_grupo:1,
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
	south:{
		  url:'../../../sis_mantenimiento/vista/equipo_medicion/IndicadoresMediciones.php',
		  title:'Indicadores', 
		  height:'30%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'IndicadoresMediciones'
	},
	dteFechaIni:new Ext.form.DateField({
		vtype: 'daterange',
	    name:  'startdt',
	    format: 'd/m/Y',
	    allowBlank: false,
        id: 'startdt'+this.idContenedor,
        endDateField: 'enddt'+this.idContenedor,
        width:103
	}),
	dteFechaFin:new Ext.form.DateField({
	    vtype: 'daterange',
	    name: 'enddt',
	    format: 'd/m/Y',
	    allowBlank: false,
        id: 'enddt'+this.idContenedor,
        startDateField: 'startdt'+this.idContenedor,
        width:103
	 }),
	 intDiasMes: new Ext.form.NumberField({
	 	name: 'numDias',
	 	allowBlank:false,
	 	width:25	
	 }),
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
	}
})
</script>
		
		