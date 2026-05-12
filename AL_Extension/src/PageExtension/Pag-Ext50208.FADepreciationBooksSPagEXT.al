PageExtension 50208 "FA Depreciation Books S_PagEXT" extends "FA Depreciation Books Subform"

{


    layout
    {
        modify("Depreciation Book Code")
        {
            trigger OnAfterValidate()
            var
                erreur01: Label 'You must add the serial number.';
            begin
                /*  IF RecFixedAsset.GET(rec."FA No.") THEN BEGIN
                      IF RecFixedAsset."Serial No." = '' THEN ERROR(erreur01);
                  END;*/
            end;
        }
        modify("Straight-Line %")
        {
            Visible = true;
        }
    }
    actions
    {

    }
    var
        RecFixedAsset: Record "Fixed Asset";
}
