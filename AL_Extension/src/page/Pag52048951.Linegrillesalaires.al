page 52048951 "Line grille salaires"
{//GL2024  ID dans Nav 2009 : "39001472"
    Editable = true;
    PageType = ListPart;
    SourceTable = "Line grid";
    Caption = 'Line grille salaires';
    //ABZApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Catégorie"; rec.Catégorie)
                {
                    ApplicationArea = Basic;
                    Caption = 'Catégorie';
                }
                field("Salaire de base"; rec."Salaire de base")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base';
                }
                // field("Mensuelle / Horraire"; rec."Mensuelle / Horraire")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Mensuelle / Horraire';
                // }
                field("<Salaire de base1>"; rec."Salaire de base")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salaire de base';

                    trigger OnValidate()
                    begin
                        /*//MESSAGE('%1  ',"Salaire de base");
                        Linegrille.RESET;
                        Linegrille.SETFILTER(Code,Code);
                        Linegrille.SETFILTER(Collège,Collège);
                        Linegrille.SETRANGE(Grade,Grade);
                        Linegrille.SETRANGE(Echelle,Echelle);
                        Linegrille.SETRANGE(Classe,Classe);
                        Linegrille.SETFILTER(Echelon,CurrForm.Matrice.MatrixRec.Echelon);
                        IF Linegrille.FIND('-') THEN BEGIN
                           IF "Salaire de base">0 THEN BEGIN
                              Linegrille."Basis salary":="Salaire de base";
                              Linegrille.MODIFY;
                              END ELSE
                              Linegrille.DELETE;
                           END //ELSE
                          { IF "Salaire de base">0 THEN BEGIN
                            Linegrille."N° sequence":=1;
                            Linegrille.Code:=Code;
                            Linegrille.Collège:=Collège;
                            Linegrille.Grade:=Grade;
                            Linegrille.Echelle:= Echelle;
                            Linegrille.Classe:=Classe;
                            Linegrille.Echelon:=CurrForm.Matrice.MatrixRec.Echelon;
                            Linegrille."Basis salary":= "Salaire de base";
                            Linegrille."Date fomula":= CurrForm.Matrice.MatrixRec."Date fomula";
                            Linegrille."User ID":=USERID;
                            Linegrille."Last Date Modified":= WORKDATE;
                            Linegrille.INSERT;
                            END;}*/

                    end;
                }
                field("Bareme Abattement"; Rec."Bareme Abattement") { ApplicationArea = all; }

                field("Taux Horaire"; Rec."Taux Horaire") { ApplicationArea = all; }
                field("Taux Horaire 15%"; Rec."Taux Horaire 15%") { ApplicationArea = all; }
                field("Taux Horaire 35%"; Rec."Taux Horaire 35%")
                {

                    ApplicationArea = all;
                }

                field("Taux Horaire 50%"; Rec."Taux Horaire 50%")
                {

                    ApplicationArea = all;
                }
                field("Taux Horaire 60%"; Rec."Taux Horaire 60%")
                {

                    ApplicationArea = all;
                }
                field("Taux Horaire 120%"; Rec."Taux Horaire 120%")
                {

                    ApplicationArea = all;
                }
            }
        }
    }
}





