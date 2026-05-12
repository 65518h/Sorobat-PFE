Page 50299 "Image Chantier"
{
    Editable = false;
    PageType = List;
    SourceTable = "Image Chantier";
    ApplicationArea = all;
    Caption = 'Image Chantier';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Nom Table"; REC."Nom Table")
                {
                    ApplicationArea = all;
                }

                field(Sequence; REC.Sequence)
                {
                    ApplicationArea = all;
                }
                field("Sequence / Document / Code"; REC."Sequence / Document / Code")
                {
                    ApplicationArea = all;
                }
                field("Ligne / Sequence"; REC."Ligne / Sequence")
                {
                    ApplicationArea = all;
                }
                field(Fournisseur; REC.Fournisseur)
                {
                    ApplicationArea = all;
                }
                field("Nom Fournisseur"; REC."Nom Fournisseur")
                {
                    ApplicationArea = all;
                }
                field(Magasin; REC.Magasin)
                {
                    ApplicationArea = all;
                }
                field("Quantité"; REC.Quantité)
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Table"; REC.Table)
                {
                    ApplicationArea = all;
                }
                field(Article; REC.Article)
                {
                    ApplicationArea = all;
                }
                field("Description Article"; REC."Description Article")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Image")
            {
                ApplicationArea = all;
                Caption = 'Update Image';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 1);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(1) then begin
                            ParametrageImage."Dernier Document" := RecImage."Sequence / Document / Code";
                            ParametrageImage.Modify;
                        end;

                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 3);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(2) then begin
                            ParametrageImage."Derniere Sequence" := RecImage."Ligne / Sequence";
                            ParametrageImage.Modify;
                        end;
                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 4);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(3) then begin
                            ParametrageImage."Dernier Document" := RecImage."Sequence / Document / Code";
                            ParametrageImage.Modify;
                        end;

                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 5);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(4) then begin
                            ParametrageImage."Dernier Document" := RecImage."Sequence / Document / Code";
                            ParametrageImage.Modify;
                        end;

                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 7);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(5) then begin
                            ParametrageImage."Dernier Document" := RecImage."Sequence / Document / Code";
                            ParametrageImage.Modify;
                        end;



                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 9);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(6) then begin
                            ParametrageImage."Dernier Document" := RecImage."Sequence / Document / Code";
                            ParametrageImage.Modify;
                        end;


                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 11);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(7) then begin
                            ParametrageImage."Dernier Document" := RecImage."Sequence / Document / Code";
                            ParametrageImage.Modify;
                        end;


                    RecImage.Reset;
                    RecImage.SetRange("Nom Table", 13);
                    if RecImage.FindLast then
                        if ParametrageImage.Get(8) then begin
                            ParametrageImage."Derniere Sequence" := RecImage."Ligne / Sequence";
                            ParametrageImage.Modify;
                        end;
                end;
            }
        }
    }

    var
        ParametrageImage: Record "Parametrage Image";
        Text001: label 'Confimer Cette Action ?';
        RecImage: Record "Image Chantier";
}

