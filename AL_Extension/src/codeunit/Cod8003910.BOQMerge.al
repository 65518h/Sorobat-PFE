Codeunit 8003910 "BOQ Merge"
{

    trigger OnRun()
    var
        lRecRef: RecordRef;
    begin
    end;

    var
        TErrorImplement: label 'The fonctionnality doesn''t yet implement';

    local procedure lLoadDocBOQ(pRecRef: RecordRef; pHeader: Boolean; var pBOQMgt: Codeunit "BOQ Management")
    var
        lSonRefs: RecordRef;
        lBOQTmp: Record "BOQ Line" temporary;
        lBOQExist: Boolean;
        lDuplicate: RecordRef;
        lBOQCust: Codeunit "BOQ Custom Management";
    begin
        /***********************************************
        *               gCalculateDesc                *
        ***********************************************
        * Entrée : RecordRef                          *
        *          Boolean                            *
        *          Codeuit BQ management              *
        * pValue : Néant                              *
        ***********************************************
        * Fonction de chargement d'un métré et de     *
        * construction de l'arborescence du fichier   *
        * xml                                         *
        ***********************************************/
        if pHeader then begin
            pBOQMgt.AddHeader(pRecRef.RecordId);
            pBOQMgt.SetCurrentNode(pRecRef.RecordId);
        end;

        lBOQTmp.DeleteAll;
        //lMergeBOQ(lBOQTmp,pRecRef);
        if not lBOQTmp.IsEmpty then begin
            lBOQTmp.FindSet(false, false);
            repeat
                pBOQMgt.AddBoqLine(lBOQTmp);
            until lBOQTmp.Next = 0;
        end;

        if lGetSonsNode(pRecRef, lSonRefs) then begin
            lSonRefs.FindSet(false, false);
            repeat
                pBOQMgt.SetCurrentNode(pRecRef.RecordId);
                pBOQMgt.AddLine(lSonRefs.RecordId);
                lDuplicate := lSonRefs.Duplicate;
                lLoadDocBOQ(lDuplicate, false, pBOQMgt);
            until lSonRefs.Next = 0;
        end;

    end;

    local procedure lGetSonsNode(pRecRef: RecordRef; var pSonRef: RecordRef): Boolean
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
        lStructSalesLine: Record "Sales Line";
        lResource: Record Resource;
        lStructureLine: Record "Structure Component";
        lSalesHeaderArch: Record "Sales Header Archive";
        lSalesLineArch: Record "Sales Line Archive";
        lStructSalesLineArch: Record "Sales Line Archive";
    begin
        /***********************************************
        *                 lGetSonsNode                *
        ***********************************************
        * Entrée : pRecRef : recordref this variable  *
        *                    define the father record *
        *          pSonRef : recordref this variable  *
        *                    define the son records   *
        * pValue : Néant                              *
        ***********************************************
        * Fonction de recherche métier de             *
        * l'arborescence                              *
        ***********************************************/
        case pRecRef.Number of
            Database::"Sales Header":
                begin
                    pRecRef.SetTable(lSalesHeader);
                    lSalesLine.Reset;
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                    lSalesLine.SetRange("Document Type", lSalesHeader."Document Type");
                    lSalesLine.SetRange("Document No.", lSalesHeader."No.");
                    lSalesLine.SetRange("Attached to Line No.", 0);
                    lSalesLine.SetRange("Structure Line No.", 0);
                    lSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::" ");
                    pSonRef.GetTable(lSalesLine);
                end;
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lSalesLine);
                    lStructSalesLine.Reset;
                    case lSalesLine."Line Type" of
                        lSalesLine."line type"::Totaling:
                            begin
                                lStructSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lStructSalesLine.SetRange("Document Type", lSalesLine."Document Type");
                                lStructSalesLine.SetRange("Document No.", lSalesLine."Document No.");
                                lStructSalesLine.SetRange("Attached to Line No.", lSalesLine."Line No.");
                                lStructSalesLine.SetRange("Structure Line No.", 0);
                            end;
                        lSalesLine."line type"::Structure:
                            begin
                                lStructSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lStructSalesLine.SetRange("Document Type", lSalesLine."Document Type");
                                lStructSalesLine.SetRange("Document No.", lSalesLine."Document No.");
                                if lSalesLine."Structure Line No." <> 0 then begin
                                    lStructSalesLine.SetRange("Attached to Line No.", lSalesLine."Line No.");
                                    lStructSalesLine.SetRange("Structure Line No.", lSalesLine."Structure Line No.");
                                end else begin
                                    lStructSalesLine.SetRange("Attached to Line No.", 0);
                                    lStructSalesLine.SetRange("Structure Line No.", lSalesLine."Line No.");
                                end;
                            end;
                        else
                            exit(false);
                    end;
                    lStructSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::" ");
                    pSonRef.GetTable(lStructSalesLine);
                end;
            Database::Resource:
                begin
                    pRecRef.SetTable(lResource);
                    lStructureLine.SetRange("Parent Structure No.", lResource."No.");
                    lStructureLine.SetFilter(Type, '<>%1', lStructureLine.Type::" ");
                    pSonRef.GetTable(lStructureLine);
                end;
            Database::"Sales Header Archive":
                begin
                    pRecRef.SetTable(lSalesHeaderArch);
                    lSalesLineArch.Reset;
                    lSalesLineArch.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                    lSalesLineArch.SetRange("Document Type", lSalesHeaderArch."Document Type");
                    lSalesLineArch.SetRange("Document No.", lSalesHeaderArch."No.");
                    lSalesLineArch.SetRange("Attached to Line No.", 0);
                    lSalesLineArch.SetRange("Structure Line No.", 0);
                    lSalesLineArch.SetFilter("Line Type", '<>%1', lSalesLine."line type"::" ");
                    pSonRef.GetTable(lSalesLineArch);
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lSalesLineArch);
                    lStructSalesLineArch.Reset;
                    case lSalesLineArch."Line Type" of
                        lSalesLine."line type"::Totaling:
                            begin
                                lStructSalesLineArch.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lStructSalesLineArch.SetRange("Document Type", lSalesLineArch."Document Type");
                                lStructSalesLineArch.SetRange("Document No.", lSalesLineArch."Document No.");
                                lStructSalesLineArch.SetRange("Attached to Line No.", lSalesLineArch."Line No.");
                                lStructSalesLineArch.SetRange("Structure Line No.", 0);
                            end;
                        lSalesLine."line type"::Structure:
                            begin
                                lStructSalesLineArch.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lStructSalesLineArch.SetRange("Document Type", lSalesLineArch."Document Type");
                                lStructSalesLineArch.SetRange("Document No.", lSalesLineArch."Document No.");
                                if lSalesLine."Structure Line No." <> 0 then begin
                                    lStructSalesLineArch.SetRange("Attached to Line No.", lSalesLineArch."Line No.");
                                    lStructSalesLineArch.SetRange("Structure Line No.", lSalesLineArch."Structure Line No.");
                                end else begin
                                    lStructSalesLineArch.SetRange("Attached to Line No.", 0);
                                    lStructSalesLineArch.SetRange("Structure Line No.", lSalesLineArch."Line No.");
                                end;
                            end;
                        else
                            exit(false);
                    end;
                    lStructSalesLineArch.SetFilter("Line Type", '<>%1', lSalesLineArch."line type"::" ");
                    pSonRef.GetTable(lStructSalesLineArch);
                end;
            else
                exit(false);
        end;
        exit(not pSonRef.IsEmpty);

    end;
}

