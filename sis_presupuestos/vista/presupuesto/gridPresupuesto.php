<?php
/**
*@package pXP
*@file      gridPresupuesto.php
*@author    Gonzalo Sarmiento
*@date      24-12-2012
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");?>
<script> 
Phx.vista.gridPresupuesto=Ext.extend(Phx.gridInterfaz,{
     constructor:function(config){
        
        
        Ext.apply(this, config);
        this.panel = Ext.getCmp(this.idContenedor);
        
        this.configMaestro=config;
        this.config=config;
        //llama al constructor de la clase padre
        
        this.storeAtributos= new Ext.data.JsonStore({
                    url:'../../sis_presupuestos/control/Presupuesto/graficaPresupuesto',
                    id: 'id_partida',
                    root: 'datos',
                    totalProperty: 'total',
                    fields: ['id_partida','codigo_par','id_presupuesto','codigo_pres','centro_costo',
                            'moneda','presup_ene','ejec_ene','presup_feb','ejec_feb','presup_mar','ejec_mar',
                            'presup_abr','ejec_abr','presup_may','ejec_may','presup_jun','ejec_jun',
                            'presup_jul','ejec_jul','presup_ago','ejec_ago','presup_sep','ejec_sep',
                            'presup_oct','ejec_oct','presup_nov','ejec_nov','presup_dic','ejec_dic'],
                    sortInfo:{
                        field: 'id_partida',
                        direction: 'ASC'
                    },
                    baseParams:{id_presupuesto:this.id_presupuesto,id_partida:''}
                    });
                        
        //evento de error
        this.storeAtributos.on('loadexception',this.conexionFailure);               
           
            //crea una ventana de parametrizacion de fechas
            
            this.formUCCL = new Ext.form.FormPanel({
                
                bodyStyle: 'padding:10 20px 10;',
                autoDestroy: true,
                border: false,
                layout: 'form',
              
                autoScroll: true,
                defaults: {
                    xtype: 'textfield'
                },
        
                items: [{
                        xtype: 'datefield',                        
                        name: 'fecha_ini',
                        fieldLabel: 'Inicia',
                        format:'d-m-Y',
                        allowBlank: false,
                        allowBlank: false               
                    },{
                        xtype: 'datefield',
                        name: 'fecha_fin',
                        fieldLabel: 'Termina',
                        format:'d-m-Y',
                        allowBlank: false,  
                        allowBlank: false                   
                    }]
            });
            
          
             this.wUCCL = new Ext.Window({
                 
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
                    handler:this.onGraficar,
                    scope:this
                    
                },{
                    text: 'Cancelar',
                    handler:function(){
                        this.wUCCL.hide();                        
                        this.panel.close();
                    },
                    scope:this
                }]
            });
          this.wUCCL.show();
    
    },
        
    onGraficar:function(){
        
        if (this.formUCCL.getForm().isValid()) {
        
        Phx.CP.loadingShow(this.idContenedor);
        
        var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
        var dateFechaFin =this.formUCCL.getForm().findField('fecha_fin');
                
        this.storeAtributos.load({
             params:{
             fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
             fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y'),             
             start:0, 
             limit:450},
             callback:this.successConstructor,
             scope:this})           
        }      
    },
    
    successConstructor:function(rec,con,res){
        
        this.Atributos=[];
        this.fields=[];
        this.id_store='id_partida'
        
        this.sortInfo={
            field: 'codigo_part',
            direction: 'ASC'
        };
        this.fields.push(this.id_store);
        this.fields.push('id_partida');
        this.fields.push('codigo_par');
        this.fields.push('presup_ene');
        this.fields.push('ejec_ene');
        this.fields.push('presup_feb');
        this.fields.push('ejec_feb');
        this.fields.push('presup_mar');
        this.fields.push('ejec_mar');
        this.fields.push('presup_abr');
        this.fields.push('ejec_abr');
        this.fields.push('presup_may');
        this.fields.push('ejec_may');
        this.fields.push('presup_jun');
        this.fields.push('ejec_jun');
        this.fields.push('presup_jul');
        this.fields.push('ejec_jul');
        this.fields.push('presup_ago');
        this.fields.push('ejec_ago');
        this.fields.push('presup_sep');
        this.fields.push('ejec_sep');
        this.fields.push('presup_oct');
        this.fields.push('ejec_oct');
        this.fields.push('presup_nov');
        this.fields.push('ejec_nov');
        this.fields.push('presup_dic');
        this.fields.push('ejec_dic');
        
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
                                        fieldLabel: 'Partida',
                                        name: 'codigo_par',
                                        gwidth:80 
                                },
                                type:'Field',
                                grid:true,
                                form:false 
                        };
            
            this.Atributos[3]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Ene',
                                        name: 'presup_ene',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_ene',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[4]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Ene',
                                        name: 'ejec_ene',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_ene',type:'string'},
                                grid:true,
                                form:false 
                        };  
                
                
            this.Atributos[5]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Feb',
                                        name: 'presup_feb',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_feb',type:'string'},
                                grid:true,
                                form:false 
                        };
            
            this.Atributos[6]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Feb',
                                        name: 'ejec_feb',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_feb',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[7]={
            //configuracion del componente
                                config:{
                                        
                                        name: 'presup_mar',
                                        fieldLabel: 'Presup Mar',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_mar',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[8]={
            //configuracion del componente
                                config:{
                                        
                                        name: 'ejec_mar',
                                        fieldLabel: 'Ejec Mar',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_mar',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[9]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Abr',
                                        name: 'presup_abr',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_abr',type:'string'},
                                grid:true,
                                form:false 
                        };  
                        
            this.Atributos[10]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Abr',
                                        name: 'ejec_abr',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_abr',type:'string'},
                                grid:true,
                                form:false 
                        };  
                
                
            this.Atributos[11]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup May',
                                        name: 'presup_may',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_may',type:'string'},
                                grid:true,
                                form:false 
                        };
            
            this.Atributos[12]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec May',
                                        name: 'ejec_may',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_may',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[13]={
            //configuracion del componente
                                config:{
                                        
                                        name: 'presup_jun',
                                        fieldLabel: 'Presup Jun',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_jun',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[14]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Jun',
                                        name: 'ejec_jun',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_jun',type:'string'},
                                grid:true,
                                form:false 
                        };  
                
                
            this.Atributos[15]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Jul',
                                        name: 'presup_jul',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_jul',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[16]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Jul',
                                        name: 'ejec_jul',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_jul',type:'string'},
                                grid:true,
                                form:false 
                        };
            
            this.Atributos[17]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Ago',
                                        name: 'presup_ago',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_ago',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[18]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Ago',
                                        name: 'ejec_ago',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_ago',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[19]={
            //configuracion del componente
                                config:{
                                        
                                        name: 'presup_sep',
                                        fieldLabel: 'Presup Sep',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_sep',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[20]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Sep',
                                        name: 'ejec_sep',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_sep',type:'string'},
                                grid:true,
                                form:false 
                        };  
                
                
            this.Atributos[21]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Oct',
                                        name: 'presup_oct',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_oct',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[22]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Oct',
                                        name: 'ejec_oct',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_oct',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[23]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Nov',
                                        name: 'presup_nov',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_nov',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            
            this.Atributos[24]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Nov',
                                        name: 'ejec_nov',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_nov',type:'string'},
                                grid:true,
                                form:false 
                        };
                        
            this.Atributos[25]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Presup Dic',
                                        name: 'presup_dic',
                                        gwidth:85 
                                },
                                type:'Field',
                                filters:{pfiltro:'presup_dic',type:'string'},
                                grid:true,
                                form:false 
                        };
            
            this.Atributos[26]={
            //configuracion del componente
                                config:{
                                        
                                        fieldLabel: 'Ejec Dic',
                                        name: 'ejec_dic',
                                        gwidth:70 
                                },
                                type:'Field',
                                filters:{pfiltro:'ejec_dic',type:'string'},
                                grid:true,
                                form:false 
                        };
            
            
            Phx.vista.gridPresupuesto.superclass.constructor.call(this,this.config);
            
             var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
             var dateFechaFin =this.formUCCL.getForm().findField('fecha_fin');
            
            this.argumentExtraSubmit={
                fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
                fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y')};
            
        
            this.init();
            
            this.addButton('btnGrafica',{
            text : 'Graficar',
            iconCls : 'bstatistics',
            disabled : true,
            handler : this.onButtonGrafica,
            tooltip : '<b>Gráfica</b><br/><b>Genera gráfica (La ordenación de los resultados afecta la gráfica)</b>'
             });
        
            
            this.store.baseParams={
                fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
                fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y'),                
                id_presupuesto:this.id_presupuesto,
                id_partida:''};                        
                                   
                                   
            this.load({params:{start:0, limit:50},callback:function(){Phx.CP.loadingHide();this.wUCCL.hide();},scope:this});
            
        }
        
    },
        
    title:'Presupuestado vs Ejecutado',
    ActList:'../../sis_presupuestos/control/Presupuesto/graficaPresupuesto',
    bdel:false,
    bsave:false,
    bnew:false,
    bedit:false,
    
    east:{
          url:'../../../sis_presupuestos/vista/presupuesto/GraficaPresupuesto.php',
          title:'Ejecutado vs Presupuestado', 
          //height:'50%',   //altura de la ventana hijo
          width:'50%',      //ancho de la ventana hjo
          cls:'GraficaPresupuesto'
    },
    
    preparaMenu:function(tb){
            //llamada funcion clace padre
            if(this.sm.getSelected()){              
                this.getBoton('btnGrafica').enable();
            }
            else{                   
                this.getBoton('btnGrafica').disable();          
            }
            Phx.vista.gridPresupuesto.superclass.preparaMenu.call(this,tb);
   },
    
    onButtonGrafica:function(){
        var rec = this.sm.getSelected();
        
        if(google&&google.visualization){
            var data = new google.visualization.DataTable();
            
            //Definición de las columnas
            data.addColumn('string', 'Fecha');
            data.addColumn('number','presupuestado');
            data.addColumn('number','ejecutado');
            
            //Cargado de los filas (valores por columnas). Se recorre todo el store para sacar los datos
            var fila = [];
            fila[0]='enero';
            fila[1]=isNaN(parseFloat(rec.data['presup_ene']))?0:parseFloat(rec.data['presup_ene']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_ene']))?0:parseFloat(rec.data['ejec_ene']);
            data.addRow(fila);
            fila[0]='febrero';
            fila[1]=isNaN(parseFloat(rec.data['presup_feb']))?0:parseFloat(rec.data['presup_feb']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_feb']))?0:parseFloat(rec.data['ejec_feb']);
            data.addRow(fila);
            fila[0]='marzo';
            fila[1]=isNaN(parseFloat(rec.data['presup_mar']))?0:parseFloat(rec.data['presup_mar']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_mar']))?0:parseFloat(rec.data['ejec_mar']);
            data.addRow(fila);
            fila[0]='abril';
            fila[1]=isNaN(parseFloat(rec.data['presup_abr']))?0:parseFloat(rec.data['presup_abr']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_abr']))?0:parseFloat(rec.data['ejec_abr']);
            data.addRow(fila);
            fila[0]='mayo';
            fila[1]=isNaN(parseFloat(rec.data['presup_may']))?0:parseFloat(rec.data['presup_may']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_may']))?0:parseFloat(rec.data['ejec_may']);
            data.addRow(fila);
            fila[0]='junio';
            fila[1]=isNaN(parseFloat(rec.data['presup_jun']))?0:parseFloat(rec.data['presup_jun']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_jun']))?0:parseFloat(rec.data['ejec_jun']);
            data.addRow(fila);
            fila[0]='julio';
            fila[1]=isNaN(parseFloat(rec.data['presup_jul']))?0:parseFloat(rec.data['presup_jul']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_jul']))?0:parseFloat(rec.data['ejec_jul']);
            data.addRow(fila);
            fila[0]='agosto';
            fila[1]=isNaN(parseFloat(rec.data['presup_ago']))?0:parseFloat(rec.data['presup_ago']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_ago']))?0:parseFloat(rec.data['ejec_ago']);
            data.addRow(fila);
            fila[0]='septiembre';
            fila[1]=isNaN(parseFloat(rec.data['presup_sep']))?0:parseFloat(rec.data['presup_sep']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_sep']))?0:parseFloat(rec.data['ejec_sep']);
            data.addRow(fila);
            fila[0]='octubre';
            fila[1]=isNaN(parseFloat(rec.data['presup_oct']))?0:parseFloat(rec.data['presup_oct']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_oct']))?0:parseFloat(rec.data['ejec_oct']);
            data.addRow(fila);
            fila[0]='noviembre';
            fila[1]=isNaN(parseFloat(rec.data['presup_nov']))?0:parseFloat(rec.data['presup_nov']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_nov']))?0:parseFloat(rec.data['ejec_nov']);
            data.addRow(fila);
            fila[0]='diciembre';
            fila[1]=isNaN(parseFloat(rec.data['presup_dic']))?0:parseFloat(rec.data['presup_dic']);
            fila[2]=isNaN(parseFloat(rec.data['ejec_dic']))?0:parseFloat(rec.data['ejec_dic']);
            data.addRow(fila);
            
              //Dibuja o actualiza la gráfica
              var pagIndicadores =  Phx.CP.getPagina(this.idContenedor+'-east');
              if(pagIndicadores){
                 pagIndicadores.setDatachart(data);
              }
         }
    }
            
}
)
</script>       