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
            id: 'fecha_ini',
            name:'fecha_ini',
            fieldLabel:'Fecha Inicio',
            allowBlank:false,
            vtype: 'daterange',
            endDateField:'fecha_fin',
            format:'d/m/Y'           
        },
        type:'DateField'
        },
        {
            config:{
                id: 'fecha_fin',
                name:'fecha_fin',
                fieldLabel:'Fecha Fin',
                allowBlank:false,
                vtype: 'daterange',
                startDateField:'fecha_ini',
                format:'d-m-Y'
            },
            type:'DateField'
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