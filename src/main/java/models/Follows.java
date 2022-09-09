package models;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import constants.JpaConst;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Table(name = "follows")
@NamedQueries({
    @NamedQuery(
            name = "followsGetAllMine",
            query = "SELECT f FROM Follows f WHERE f.code = :code"),
    @NamedQuery(
            name = "followGetData",
            query = "SELECT f FROM Follows f WHERE f.code =:code "),
})

@Getter //全てのクラスフィールドについてgetterを自動生成する(Lombok)
@Setter //全てのクラスフィールドについてsetterを自動生成する(Lombok)
@NoArgsConstructor //引数なしコンストラクタを自動生成する(Lombok)
@AllArgsConstructor //全てのクラスフィールドを引数にもつ引数ありコンストラクタを自動生成する(Lombok)
@Entity
public class Follows {

    /**
     * id
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 日報を登録した従業員
     */
    @Column(name = "code", nullable = false)
    private String code;
    /**
     * フォローした社員
     */
    @ManyToOne
    @JoinColumn(name = "follow_code", nullable = false)
    private Employee followCode;

    /**
     * 登録日時
     */
    @Column(name = JpaConst.REP_COL_CREATED_AT, nullable = false)
    private LocalDateTime createdAt;



}