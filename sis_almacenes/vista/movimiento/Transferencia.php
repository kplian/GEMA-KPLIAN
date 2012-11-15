<?php
/**
 * @package         pxP
 * @file            Transferencia.php
 * @author          Gonzalo Sarmiento
 * @descripcion     Archivo con las interfaz de usuario que permite la funcionalidad de finalizar un Ingreso
 * @date            09-10-2012 
 */
 include_once("TransferenciaAbs.php");
 header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Transferencia=Ext.extend(Phx.vista.TransferenciaAbs,{
        constructor : function(config){
            this.maestro = config.maestro;
            Phx.vista.Transferencia.superclass.constructor.call(this,config);
            this.init();
            this.addButton('FinTransferencia',{text:'Finalizar',iconCls:'bend',disabled:true,handler:FinTransferencia,tooltip:'<b>Finzalizar Transferencia'});
            
            function FinTransferencia(){                    
                var data = this.sm.getSelected().data.id_movimiento;
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    // form:this.form.getForm().getEl(),
                    url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
                    params:{'id_movimiento':data,'operacion':'finalizarTransferencia'},                 
                    success:this.successSinc,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                });     
            }
            this.load({params:{start:0, limit:50, codigo:'TRANSFERENCIA'}})
        },
        successSinc:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                alert(reg.ROOT.detalle.mensaje)
                
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
            this.reload();
            
        },      
        title:'Transferencia',
        bdel:true,
        bend:true,
        bedit:true,
        bnew:true,
        preparaMenu:function(tb){
            //llamada funcion clace padre
            if(this.sm.getSelected().data.estado_mov=='borrador'){              
                this.getBoton('FinTransferencia').enable();
            }
            else{                   
                this.getBoton('FinTransferencia').disable();                
            }
            Phx.vista.Transferencia.superclass.preparaMenu.call(this,tb);
        }
    })
</script>
