PageExtension 50199 "Employee Statistics Gr_PagEXT" extends "Employee Statistics Groups"

{

    layout
    {
        addafter(code)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
            field(Departement; Rec.Departement)
            {
                ApplicationArea = all;
            }
            field(Section; Rec.Section)
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(UpdateDim)
            {
                ApplicationArea = all;
                Image = UpdateXML;
                caption = 'Mise à jour des axes salariés';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    RecLEmp: Record Employee;
                begin
                    if rec.FindFirst() then
                        repeat
                            RecLEmp.Reset();
                            RecLEmp.setrange(service, rec.code);
                            if RecLEmp.FindFirst() then
                                repeat
                                    RecLEmp.validate("Global Dimension 1 Code", rec."Global Dimension 1 Code");
                                    RecLEmp.validate("Global Dimension 2 Code", rec."Global Dimension 2 Code");
                                until RecLEmp.Next() = 0;
                        until rec.Next() = 0;
                    message('Traitement terminée.');
                end;

            }
        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
        IF HumanResourcesSetup.GET THEN;
        IF HumanResourcesSetup."Filtre Departement" <> '' THEN BEGIN
            rec.SETFILTER(Code, COPYSTR(HumanResourcesSetup."Filtre Departement", 1, 1) + '*');
            rec.SETRANGE(Type, rec.Type::Service);
        END;
    end;

    var
        HumanResourcesSetup: Record 5218;
}