/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inst.pojo;

/**
 *
 * @author Muzaffar
 */
public class SprGroup {
    private int id;
    private String name;
    private int idFac;

    public SprGroup() {
    }

    public SprGroup(int id, String name, int idFac) {
        this.id = id;
        this.name = name;
        this.idFac = idFac;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIdFac() {
        return idFac;
    }

    public void setIdFac(int idFac) {
        this.idFac = idFac;
    }

    @Override
    public String toString() {
        return "SprGroup{" + "id=" + id + ", name=" + name + ", idFac=" + idFac + '}';
    }
    
}
