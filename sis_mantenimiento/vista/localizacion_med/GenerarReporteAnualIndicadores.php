<?php
/**
*@package pXP
*@file    GenerarReporteAnualIndicadores.php
*@author  Gonzalo Sarmiento Sejas
*@date    09-01-2013
*@description Archivo con la interfaz para generación de reporte
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GenerarReporteAnualIndicadores=Ext.extend(Phx.frmInterfaz,{
    Atributos:[
        {
            config:{                
                name:'anio',
                fieldLabel:'Año',
                allowBlank:false,
                emptyText:'Año...',
                store: ['2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022','2023','2024','2025'],
                valueField: 'anio',
                displayField: 'anio',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',
                width:130,               
                renderer:function(value, p, record){return String.format('{0}', record.data['anio']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'anio',
                type:'string'
            },
            grid:true,
            form:true
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
                    name: 'id_localizacion'
            },
            type:'Field',
            form:true 
        },
        {
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
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'localizacion'
            },
            type:'Field',
            form:true 
        },        
    ],
    title:'Generar Reporte Anual',
    ActSave:'../../sis_mantenimiento/control/LocalizacionMed/reporteAnualLocalizacionMed',
    topBar:true,
    botones:false,
    labelSubmit:'Imprimir',
    tooltipSubmit:'<b>Generar Reporte Anual Indicadores</b>',    
    
    constructor: function(config){
        Phx.vista.GenerarReporteAnualIndicadores.superclass.constructor.call(this,config);
        this.init();        
        this.getComponente('id_localizacion').setValue(this.id_localizacion);
        this.getComponente('tipo_nodo').setValue(this.tipo_nodo);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);
        this.getComponente('localizacion').setValue(this.nombre);      
    },
    tipo:'reporte',
    clsSubmit:'bprint'
    
})
</script>