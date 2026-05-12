Codeunit 8001432 IntegrManagement
{
    // #9252 CW 24/01/12
    // #0 CW 25/10/11 gLoaded (évite initialisation en codeunit 1)
    // //+BGW+ CW 19/11/11 +Contract
    // //+BGW+ CW 06/12/10 +Equipment
    // //+BGW+ AC 26/10/10 **Attention le codeunit est en singleInstance** (ne pas oulier de redémarrer les services aprés modification)
    //                     Ajout de la fonction fGetPermission, cette fonction permet de tester si la licence
    //                     permet de lire des table dans une plage d'objet
    //                     Ajout de la fonction LoadPermission (appelé dans le codeunit1)
    // WARNING : SingleInstance = YES

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        gLoaded: Boolean;
        gABO: Boolean;
        gBGW: Boolean;
        gPLA: Boolean;
        gPMT: Boolean;
        gRAP: Boolean;
        gREF: Boolean;
        gREP: Boolean;
        gSTA: Boolean;
        gWKF: Boolean;
        gEquipment: Boolean;
        gContract: Boolean;

    local procedure fGetPermission(pID: Integer) Return: Boolean
    var
        lLicencePermission: Record "License Permission";
    begin
        //#9252
        /*
        lLicencePermission.SETRANGE("Object Number",pBeginGranule,pEndGranule);
        lLicencePermission.SETRANGE("Object Type",lLicencePermission."Object Type"::TableData);
        lLicencePermission.SETRANGE("Read Permission",lLicencePermission."Read Permission"::Yes
                                                     ,lLicencePermission."Read Permission"::Indirect);
        Return := NOT lLicencePermission.ISEMPTY;
        */
        with lLicencePermission do
            exit(Get("object type"::TableData, pID) and ("Read Permission" <> 0));
        //#9252//

    end;


    procedure LoadPermission()
    begin
        if gLoaded then
            exit;
        //#9252
        /*
        gABO := fGetPermission(8001900,8001999);
        gBGW := fGetPermission(8001400,8001499);
        gPLA := fGetPermission(8035000,8035099);
        gPMT := fGetPermission(8004100,8004129);
        gRAP := fGetPermission(8001600,8001699);
        gREF := fGetPermission(8001400,8001499);
        gREP := fGetPermission(8003500,8003599);
        gSTA := fGetPermission(8001300,8001399);
        gWKF := fGetPermission(8004200,8004299);
        */
        gABO := fGetPermission(8001900);
        gBGW := fGetPermission(8001400);
        gPLA := fGetPermission(8035000);
        gPMT := fGetPermission(8004100);
        gRAP := fGetPermission(8001600);
        gREF := fGetPermission(8001400);
        gREP := fGetPermission(8003500);
        gSTA := fGetPermission(8001300);
        gWKF := fGetPermission(8004200);
        //#9252//

        gLoaded := true;

    end;


    procedure HasPermissionABO() Return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Abonnement
        Return := gABO;
    end;


    procedure HasPermissionBGW() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Basic Gesway
        return := gBGW;
    end;


    procedure HasPermissionPLA() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Planning
        return := gPLA;
    end;


    procedure HasPermissionPMT() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Paiement
        return := gPMT;
    end;


    procedure HasPermissionRAP() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Rapprochement automatique
        return := gRAP;
    end;


    procedure HasPermissionREF() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Référence
        return := gREF;
    end;


    procedure HasPermissionREP() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Répartition Analytique
        return := gREP;
    end;


    procedure HasPermissionSTA() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on StatsExplorer
        return := gSTA;
    end;


    procedure HasPermissionWKF() return: Boolean
    begin
        LoadPermission;
        //Test de l'add-on Workflow
        return := gWKF;
    end;


    procedure Undefined(var pRecordRef: RecordRef; pFieldNo: Integer; pPoint: Text[30])
    var
        lFieldRef: FieldRef;
        ltField: label 'Integration %1 not defined';
        ltPoint: label 'Integration point %1 not defined for table %2.';
    begin
        if pFieldNo = 0 then
            Error(ltPoint, pPoint, pRecordRef.Caption)
        else begin
            lFieldRef := pRecordRef.Field(pFieldNo);
            lFieldRef.FieldError(StrSubstNo(ltField, pPoint));
        end;
    end;


    procedure Equipment() return: Boolean
    begin
        LoadPermission;
        return := true; // à revoir
    end;


    procedure Contract() return: Boolean
    begin
        LoadPermission;
        exit(true); // à revoir
    end;
}

