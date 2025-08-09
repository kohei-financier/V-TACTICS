import { Application } from "@hotwired/stimulus"
// stimulus-autocompleteをインポートして、「Autocomplete」というクラスを使えるようにしている。
import { Autocomplete } from "stimulus-autocomplete"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// インポートしてAutocompleteというクラス（機能）を"autocomplete"という名前でアプリ内で使えるようにします。
application.register("autocomplete", Autocomplete)

export { application }
