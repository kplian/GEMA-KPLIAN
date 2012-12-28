<?php
/**
*@package pXP
*@file GeneraReportePresupuesto.php
*@author  Gonzalo Sarmiento Sejas
*@date 07-12-2012
*@description Archivo con la interfaz para generación de reporte
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GeneraReportePresupuesto=Ext.extend(Phx.frmInterfaz,{
    Atributos:[
        {
            config:{
                name:'id_presupuesto',
                fieldLabel: 'Presupuesto',
                allowBlank:false,
                store: new Ext.data.JsonStore({
                    url: '../../sis_presupuestos/control/Presupuesto/listarPresupuesto',
                    id: 'id_presupuesto',
                    root: 'datos',
                    sortInfo:{
                        field: 'id_presupuesto',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_presupuesto','codigo','descripcion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'presupuesto'}          
                }),      
            valueField: 'id_presupuesto',
            displayField: 'codigo',
            mode:'remote',
            triggerAction: 'all',
            pageSize:10,
            queryDelay:500,
            width:300,
            minChars:2,
            enableMultiSelect: true
            },
        type:'AwesomeCombo'
        },         
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
                name:'id_partida',
                fieldLabel: 'Partida',
                allowBlank:false,
                store: new Ext.data.JsonStore({
                    url: '../../sis_presupuestos/control/Partida/listarPartida',
                    id: 'id_partida',
                    root: 'datos',
                    sortInfo:{
                        field: 'id_partida',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_partida','codigo','descripcion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'codigo'}          
                }),      
            valueField: 'id_partida',
            displayField: 'codigo',
            mode:'remote',
            triggerAction: 'all',
            pageSize:10,
            queryDelay:500,
            width:300,
            minChars:2,            
            enableMultiSelect: true
            },
        type:'AwesomeCombo'
        }
    ],
    title:'Generar Reporte',
    ActSave:'../../sis_presupuestos/control/Presupuesto/reportePresupuesto',
    topBar:true,
    botones:false,
    labelSubmit:'Imprimir',
    tooltipSubmit:'<b>Generar reporte</b>',    
    
    constructor: function(config){
        Phx.vista.GeneraReportePresupuesto.superclass.constructor.call(this,config);
        this.init();
      
    },
    tipo:'reporte',
    clsSubmit:'bprint'
    
})
</script>