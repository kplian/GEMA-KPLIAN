<?php
/** 
*@package pXP
*@file gen-TipoEvento.php
*@author  (prueba1)
*@date 13-10-2011 11:22:31
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.pivotCalendar=Ext.extend(Phx.baseInterfaz,{
	
	constructor: function(config) {
		
		console.log(config)
		
		Phx.vista.pivotCalendar.superclass.constructor.call(this, config);
		//si es tipo grilla editable tabien los inicia
    	this.definirComponentes();
    	//definir formulario tipo venatana
    	this.definirFormularioVentana();
		
		//definicion de la barra de meno
		this.defineMenu();
		
				var SaleRecord = Ext.data.Record.create([
		        {name: 'person',   type: 'string'},
		        {name: 'product',  type: 'string'},
		        {name: 'city',     type: 'string'},
		        {name: 'state',    type: 'string'},
		        {name: 'month',    type: 'int'},
		        {name: 'quarter',  type: 'int'},
		        {name: 'year',     type: 'int'},
		        {name: 'quantity', type: 'int'},
		        {name: 'value',    type: 'int'}
		    ]);
		    
		    var myStore = new Ext.data.Store({
		        url: '../../../sis_mantenimiento/vista/localizacion/simple.json',
		        autoLoad: true,
		        //params:_tipo:'direc',
		        baseParams :{_tipo:'direc'},
		        reader: new Ext.data.JsonReader({
		            root: 'rows',
		            idProperty: 'id'
		        }, SaleRecord)
		    });
		    
		    myStore.load()
		    
		    this.pivotGrid = new Ext.grid.PivotGrid({
		        
		        
		        //layout    :    'fit',
		        tbar:this.tbar,
		       /* bbar: new Ext.PagingToolbar({
				pageSize:100,
				store:myStore,
				displayInfo: true,
				displayMsg: 'Registros {0} - {1} de {2}',
				emptyMsg: "No se tienen registros"
			}),*/
			
		       region: 'center',
		        store     : myStore,
		        aggregator: 'sum',
		        measure   : 'value',
		        
		        viewConfig: {
		            title: 'Sales Performance'
		        },
		        
		        leftAxis: [
		            {
		                width: 80,
		                dataIndex: 'person'
		            },
		            {
		                width: 90,
		                dataIndex: 'product'
		            }
		        ],
		        
		        topAxis: [
		            {
		                dataIndex: 'year'
		            },
		            {
		                dataIndex: 'city'
		            }
		        ]
		    });
		
		
			this.defineMenu();
	        this.regiones= new Array();
		//ubica el grid en la region central
		this.regiones.push(this.pivotGrid);
		/*arma los panles de ventanas hijo*/
		this.definirRegiones()
		 this.panel.doLayout(true,true)
		
	}
	

	
	
	})
</script>