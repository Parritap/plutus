package dev.estebanparra.plutus

import io.quarkus.hibernate.orm.panache.kotlin.PanacheEntity
import jakarta.persistence.Entity
import jakarta.persistence.Table
import java.time.LocalDate

@Entity
@Table(name = "person")
class Person : PanacheEntity() {
    lateinit var firstName: String
    lateinit var lastName: String
    lateinit var email: String
    lateinit var birthDate: LocalDate
}
