<?php
/**
*@package pXP
*@file GenerarReporteIndicadores.php
*@author  Gonzalo Sarmiento Sejas
*@date    04-01-2013
*@description Archivo con la interfaz para generación de reporte
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GenerarReporteIndicadores=Ext.extend(Phx.frmInterfaz,{
    Atributos:[
        {
            config:{                
                name:'mes',
                fieldLabel:'Mes',
                allowBlank:false,
                emptyText:'Mes...',
                store: ['January','February','March','April','May','June','July','August','September','October','November','December'],
                valueField: 'mes',
                displayField: 'mes',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',
                width:130,               
                renderer:function(value, p, record){return String.format('{0}', record.data['mes']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'mes',
                type:'string'
            },
            grid:true,
            form:true
        },
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
    title:'Generar Reporte',
    ActSave:'../../sis_mantenimiento/control/LocalizacionMed/reporteLocalizacionMed',
    topBar:true,
    botones:false,
    labelSubmit:'Imprimir',
    tooltipSubmit:'<b>Generar Reporte Indicadores</b>',    
    
    constructor: function(config){
        Phx.vista.GenerarReporteIndicadores.superclass.constructor.call(this,config);
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