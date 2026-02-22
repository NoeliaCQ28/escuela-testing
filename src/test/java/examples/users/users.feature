Feature: Automatizar el backend de Pet Store
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url apiPetStore

  @TEST-1
  Scenario: Verificar la creación de una nueva mascota en Pet Store - Ok
    * def petCreation =
      """
      {
        "id": 0,
        "category": {
          "id": 0,
          "name": "string"
        },
        "name": "doggie",
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 0,
            "name": "string"
          }
        ],
        "status": "available"
      }
      """

    Given path 'pet'
    And request petCreation
    When method post
    Then status 200
    And print response

  @TEST-2
  Scenario: Verificar el estado de la mascota creada anteriormente en Pet Store - Ok

    Given path 'pet/findByStatus'
    And param status = 'available', 'pending', 'sold'
    When method get
    Then status 200
    And print response

  @TEST-3
  Scenario Outline: Buscar por estado

    Given path 'pet', 'findByStatus'
    And param status = '<status>'
    When method get
    Then status 200
    And print response
    Examples:
      | status     |
      | available  |
      | pending    |
      | sold       |

  @TEST-4
  Scenario: Verificar la actualizacion de mascota en Pet Store - Ok
    * def petUpdate =
      """
      {
        "id": 0,
        "category": {
          "id": 0,
          "name": "string"
        },
        "name": "doggie",
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 0,
            "name": "string"
          }
        ],
        "status": "available"
      }
      """

    Given path 'pet'
    And request petUpdate
    When method put
    Then status 200
    And print response

  @TEST-5
  Scenario Outline: Verificar la mascota por su id -O

    Given path 'pet/' + <idPet>
    When method get
    Then status 200
    And print response
    Examples:
      | idPet     |
      | 1  |
      | 2    |
      | 3       |

  @TEST-6
  Scenario Outline: Eliminar la mascota por su id -O

    Given path 'pet/' + <idPet>
    When method delete
    Then status 200
    And print response
    Examples:
      | idPet     |
      | 1         |
      | 2         |
      | 3         |

  @TEST-7
  Scenario : Verificar que suba una imagen mediante el id de la mascota -OK

    Given path 'pet/' + '1' + 'uploadImage'
    And request

    When method post


  @TEST-8
  Scenario: Verificar la subida de imagen para una mascota en Pet Store - Ok
    * def petId = 0

    Given path 'pet', petId, 'uploadImage'

    And multipart field additionalMetadata = 'Imagen de un dragón genial'
    And multipart file file = { read: 'perro.png', filename: 'perro.png', contentType: 'image/png' }

    When method post
    Then status 200
    And print response


