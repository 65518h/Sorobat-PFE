reportextension 50001 "Carry Out Action Msg.Req. Ext" extends "Carry Out Action Msg. - Req."
{
    dataset
    {
    }

    requestpage
    {
    }

    rendering
    {

    }
    procedure wSetOrderKO(VAR pOrderKO: Boolean)
    begin

        wOrderKO := pOrderKO;
    end;

    var
        wOrderKO: Boolean;
}